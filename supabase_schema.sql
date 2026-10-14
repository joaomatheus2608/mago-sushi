-- ========================================================
-- MAGO SUSHI - SCHEMA E DADOS INICIAIS DO SUPABASE
-- Execute este script completo no SQL Editor do seu Supabase Dashboard:
-- https://supabase.com/dashboard/project/_/sql
-- ========================================================

-- 1. HABILITAR EXTENSÕES NECESSÁRIAS
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ========================================================
-- 2. CRIAÇÃO DAS TABELAS
-- ========================================================

-- TABELA: settings (Configurações da Loja)
CREATE TABLE IF NOT EXISTS public.settings (
    id TEXT PRIMARY KEY DEFAULT 'store-settings',
    name TEXT NOT NULL DEFAULT 'Mago Sushi',
    slogan TEXT DEFAULT 'O melhor sushi delivery da região!',
    address TEXT DEFAULT 'Jaboatão Centro - PE',
    whatsapp TEXT DEFAULT '5581991421295',
    instagram TEXT DEFAULT '@magosushidelivery',
    delivery_fee NUMERIC(10,2) DEFAULT 5.00,
    min_order_value NUMERIC(10,2) DEFAULT 20.00,
    store_status_mode TEXT DEFAULT 'auto',
    closed_message TEXT DEFAULT 'Estamos fechados no momento. Horário: Quarta a Segunda das 17:30 às 23:00 (Terça-feira fechado). Sábado e Domingo almoço das 11:00 às 15:00 e jantar das 17:30 às 23:00.',
    admin_password_hash TEXT DEFAULT 'chomelhor',
    pix_key TEXT DEFAULT '5581991421295',
    pix_type TEXT DEFAULT 'Telefone',
    pix_beneficiary TEXT DEFAULT 'Mago Sushi',
    updated_at TIMESTAMPTZ DEFAULT timezone('utc'::text, now())
);

-- TABELA: operating_hours (Horários de Funcionamento)
CREATE TABLE IF NOT EXISTS public.operating_hours (
    id SERIAL PRIMARY KEY,
    day_of_week INTEGER NOT NULL UNIQUE CHECK (day_of_week BETWEEN 0 AND 6),
    day_name TEXT NOT NULL,
    open_time TEXT NOT NULL DEFAULT '17:30',
    close_time TEXT NOT NULL DEFAULT '23:00',
    open_time2 TEXT DEFAULT NULL,
    close_time2 TEXT DEFAULT NULL,
    is_open BOOLEAN NOT NULL DEFAULT true
);

-- TABELA: categories (Categorias do Cardápio)
CREATE TABLE IF NOT EXISTS public.categories (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    slug TEXT NOT NULL,
    order_index INTEGER DEFAULT 0,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT timezone('utc'::text, now())
);

-- TABELA: products (Cardápio e Produtos)
CREATE TABLE IF NOT EXISTS public.products (
    id TEXT PRIMARY KEY,
    category_id TEXT REFERENCES public.categories(id) ON DELETE SET NULL,
    name TEXT NOT NULL,
    description TEXT DEFAULT '',
    price NUMERIC(10,2) DEFAULT 0.00,
    price_p NUMERIC(10,2) DEFAULT 0.00,
    price_m NUMERIC(10,2) DEFAULT 0.00,
    price_g NUMERIC(10,2) DEFAULT 0.00,
    has_sizes BOOLEAN DEFAULT false,
    sizes JSONB DEFAULT '[]'::jsonb,
    image_url TEXT,
    is_promo BOOLEAN DEFAULT false,
    is_active BOOLEAN DEFAULT true,
    is_available BOOLEAN DEFAULT true,
    order_index INTEGER DEFAULT 0,
    sales_channel TEXT DEFAULT 'todos',
    promo_price NUMERIC(10,2) DEFAULT 0.00,
    promo_days JSONB DEFAULT '[]'::jsonb,
    monday_price NUMERIC(10,2) DEFAULT 0.00,
    created_at TIMESTAMPTZ DEFAULT timezone('utc'::text, now()),
    updated_at TIMESTAMPTZ DEFAULT timezone('utc'::text, now())
);

-- TABELA: optionals (Adicionais / Ingredientes Extras)
CREATE TABLE IF NOT EXISTS public.optionals (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    price NUMERIC(10,2) DEFAULT 0.00,
    is_active BOOLEAN DEFAULT true,
    target TEXT DEFAULT 'all',
    applicable_category_ids JSONB DEFAULT '[]'::jsonb,
    order_index INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT timezone('utc'::text, now())
);

-- TABELA: neighborhoods (Bairros e Taxas de Entrega)
CREATE TABLE IF NOT EXISTS public.neighborhoods (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    delivery_fee NUMERIC(10,2) NOT NULL DEFAULT 5.00,
    is_active BOOLEAN DEFAULT true,
    order_index INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT timezone('utc'::text, now())
);

-- TABELA: couriers (Entregadores / Motoboys)
CREATE TABLE IF NOT EXISTS public.couriers (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    phone TEXT DEFAULT '',
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT timezone('utc'::text, now())
);

-- TABELA: orders (Pedidos em Tempo Real)
CREATE TABLE IF NOT EXISTS public.orders (
    id TEXT PRIMARY KEY,
    order_number BIGSERIAL,
    customer_name TEXT,
    customer_phone TEXT,
    order_type TEXT DEFAULT 'delivery',
    delivery_fee NUMERIC(10,2) DEFAULT 0.00,
    subtotal NUMERIC(10,2) DEFAULT 0.00,
    discount NUMERIC(10,2) DEFAULT 0.00,
    total NUMERIC(10,2) DEFAULT 0.00,
    payment_method TEXT,
    change_for NUMERIC(10,2),
    address_street TEXT,
    address_number TEXT,
    address_neighborhood TEXT,
    address_complement TEXT,
    address_reference TEXT,
    notes TEXT,
    status TEXT DEFAULT 'novo',
    courier_name TEXT,
    items JSONB DEFAULT '[]'::jsonb,
    delivery_address JSONB DEFAULT '{}'::jsonb,
    user_id TEXT,
    table_number INTEGER,
    whatsapp_sent BOOLEAN DEFAULT false,
    created_at TIMESTAMPTZ DEFAULT timezone('utc'::text, now()),
    updated_at TIMESTAMPTZ DEFAULT timezone('utc'::text, now())
);

-- TABELA: users (Clientes Cadastrados)
CREATE TABLE IF NOT EXISTS public.users (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    phone TEXT UNIQUE NOT NULL,
    password_hash TEXT,
    role TEXT DEFAULT 'client',
    created_at TIMESTAMPTZ DEFAULT timezone('utc'::text, now())
);

-- TABELA: addresses (Endereços Salvos de Clientes)
CREATE TABLE IF NOT EXISTS public.addresses (
    id TEXT PRIMARY KEY,
    user_id TEXT REFERENCES public.users(id) ON DELETE CASCADE,
    label TEXT DEFAULT 'Casa',
    street TEXT NOT NULL,
    number TEXT NOT NULL,
    neighborhood TEXT NOT NULL,
    complement TEXT,
    reference TEXT,
    created_at TIMESTAMPTZ DEFAULT timezone('utc'::text, now())
);

-- TABELA: cash_closings (Fechamento de Caixa)
CREATE TABLE IF NOT EXISTS public.cash_closings (
    id TEXT PRIMARY KEY,
    date_ref TEXT NOT NULL,
    total_orders INTEGER DEFAULT 0,
    total_revenue NUMERIC(10,2) DEFAULT 0.00,
    details JSONB DEFAULT '{}'::jsonb,
    created_at TIMESTAMPTZ DEFAULT timezone('utc'::text, now())
);

-- ========================================================
-- 3. POLÍTICAS DE SEGURANÇA (ROW LEVEL SECURITY - RLS)
-- Permite leitura e escrita públicas (anon) para o funcionamento do Delivery
-- ========================================================

ALTER TABLE public.settings ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.operating_hours ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.products ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.optionals ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.neighborhoods ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.couriers ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.addresses ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.cash_closings ENABLE ROW LEVEL SECURITY;

-- Políticas de Acesso Total para anon e authenticated
DO $$
DECLARE
    tbl text;
BEGIN
    FOR tbl IN 
        SELECT tablename FROM pg_tables WHERE schemaname = 'public'
    LOOP
        EXECUTE format('DROP POLICY IF EXISTS "Public Access %I" ON public.%I', tbl, tbl);
        EXECUTE format('CREATE POLICY "Public Access %I" ON public.%I FOR ALL TO anon, authenticated USING (true) WITH CHECK (true)', tbl, tbl);
    END LOOP;
END $$;

-- ========================================================
-- 4. BUCKET DE ARMAZENAMENTO PARA IMAGENS (Storage)
-- ========================================================

INSERT INTO storage.buckets (id, name, public)
VALUES ('products', 'products', true)
ON CONFLICT (id) DO UPDATE SET public = true;

-- Permissão de leitura e upload público no bucket products
DROP POLICY IF EXISTS "Public Products Storage Read" ON storage.objects;
CREATE POLICY "Public Products Storage Read" ON storage.objects
FOR SELECT TO anon, authenticated USING (bucket_id = 'products');

DROP POLICY IF EXISTS "Public Products Storage Insert" ON storage.objects;
CREATE POLICY "Public Products Storage Insert" ON storage.objects
FOR INSERT TO anon, authenticated WITH CHECK (bucket_id = 'products');

DROP POLICY IF EXISTS "Public Products Storage Update" ON storage.objects;
CREATE POLICY "Public Products Storage Update" ON storage.objects
FOR UPDATE TO anon, authenticated USING (bucket_id = 'products');

DROP POLICY IF EXISTS "Public Products Storage Delete" ON storage.objects;
CREATE POLICY "Public Products Storage Delete" ON storage.objects
FOR DELETE TO anon, authenticated USING (bucket_id = 'products');

-- ========================================================
-- 5. SUPABASE REALTIME
-- ========================================================

DO $$
BEGIN
    ALTER PUBLICATION supabase_realtime ADD TABLE public.orders;
EXCEPTION WHEN OTHERS THEN NULL;
END $$;

DO $$
BEGIN
    ALTER PUBLICATION supabase_realtime ADD TABLE public.settings;
EXCEPTION WHEN OTHERS THEN NULL;
END $$;

DO $$
BEGIN
    ALTER PUBLICATION supabase_realtime ADD TABLE public.products;
EXCEPTION WHEN OTHERS THEN NULL;
END $$;

-- ========================================================
-- 6. DADOS INICIAIS (SEED DATA - MAGO SUSHI)
-- ========================================================

-- Configurações da Loja
INSERT INTO public.settings (id, name, slogan, address, whatsapp, instagram, delivery_fee, min_order_value, store_status_mode, closed_message, admin_password_hash, pix_key, pix_type, pix_beneficiary)
VALUES (
    'store-settings',
    'Mago Sushi',
    'O melhor sushi delivery da região!',
    'Jaboatão Centro - PE',
    '5581991421295',
    '@magosushidelivery',
    5.00,
    20.00,
    'auto',
    'Estamos fechados no momento. Horário: Quarta a Segunda das 17:30 às 23:00 (Terça-feira fechado). Sábado e Domingo almoço das 11:00 às 15:00 e jantar das 17:30 às 23:00.',
    'chomelhor',
    '5581991421295',
    'Telefone',
    'Mago Sushi'
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    slogan = EXCLUDED.slogan,
    whatsapp = EXCLUDED.whatsapp,
    instagram = EXCLUDED.instagram,
    pix_key = EXCLUDED.pix_key,
    closed_message = EXCLUDED.closed_message;

-- Horários de Funcionamento (Quarta a Segunda, 17:30 às 23:00 | Terça fechado | Sáb e Dom almoço 11:00 às 15:00)
INSERT INTO public.operating_hours (day_of_week, day_name, open_time, close_time, open_time2, close_time2, is_open)
VALUES 
    (0, 'Domingo', '11:00', '15:00', '17:30', '23:00', true),
    (1, 'Segunda-feira', '17:30', '23:00', NULL, NULL, true),
    (2, 'Terça-feira', '17:30', '23:00', NULL, NULL, false),
    (3, 'Quarta-feira', '17:30', '23:00', NULL, NULL, true),
    (4, 'Quinta-feira', '17:30', '23:00', NULL, NULL, true),
    (5, 'Sexta-feira', '17:30', '23:00', NULL, NULL, true),
    (6, 'Sábado', '11:00', '15:00', '17:30', '23:00', true)
ON CONFLICT (day_of_week) DO UPDATE SET
    open_time = EXCLUDED.open_time,
    close_time = EXCLUDED.close_time,
    open_time2 = EXCLUDED.open_time2,
    close_time2 = EXCLUDED.close_time2,
    is_open = EXCLUDED.is_open;

-- Categorias do Cardápio
INSERT INTO public.categories (id, name, slug, order_index, is_active)
VALUES
    ('cat-especiais', 'Especiais', 'especiais', 1, true),
    ('cat-cariocas', 'Cariocas', 'cariocas', 2, true),
    ('cat-hossomakis', 'Hossomakis', 'hossomakis', 3, true),
    ('cat-uramakis', 'Uramakis', 'uramakis', 4, true),
    ('cat-temakis', 'Temakis', 'temakis', 5, true),
    ('cat-combos', 'Combos', 'combos', 6, true),
    ('cat-bebidas', 'Bebidas', 'bebidas', 7, true)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    slug = EXCLUDED.slug,
    order_index = EXCLUDED.order_index;

-- Adicionais
INSERT INTO public.optionals (id, name, price, is_active, order_index)
VALUES
    ('opt-shoyu', 'Shoyu', 2.00, true, 1),
    ('opt-teriaki', 'Teriaki', 2.00, true, 2),
    ('opt-wasabi', 'Wasabi', 2.00, true, 3),
    ('opt-gengibre', 'Gengibre', 2.00, true, 4),
    ('opt-cream-cheese', 'Cream Cheese', 3.00, true, 5)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    price = EXCLUDED.price;

-- Bairros e Taxas de Entrega
INSERT INTO public.neighborhoods (id, name, delivery_fee, is_active, order_index)
VALUES
    ('bairro-1', 'Alphaville', 15.00, true, 1),
    ('bairro-2', 'Alto da Fabrica', 6.00, true, 2),
    ('bairro-3', 'Alto do Vento', 15.00, true, 3),
    ('bairro-4', 'Bulhoes', 6.00, true, 4),
    ('bairro-5', 'Cascata', 7.00, true, 5),
    ('bairro-6', 'Coqueiral', 20.00, true, 6),
    ('bairro-7', 'Cavaleiro (Antes da Estacao)', 15.00, true, 7),
    ('bairro-8', 'Cavaleiro (Bairros)', 20.00, true, 8),
    ('bairro-9', 'Curado 1 / 2 / 3 / 4', 20.00, true, 9),
    ('bairro-10', 'Dois Carneiros (Ate Fund. Bradesco / Yapoatam)', 15.00, true, 10),
    ('bairro-11', 'Dois Carneiros (Apos Fund. Bradesco)', 20.00, true, 11),
    ('bairro-12', 'Engenho Velho', 7.00, true, 12),
    ('bairro-13', 'Floriano', 10.00, true, 13),
    ('bairro-14', 'Lote 56 (Terminal)', 7.00, true, 14),
    ('bairro-15', 'Lote 56 (Casinhas)', 10.00, true, 15),
    ('bairro-16', 'Lote 92', 7.00, true, 16),
    ('bairro-17', 'Lote 92 (Colonia dos Padres)', 8.00, true, 17),
    ('bairro-18', 'Tenda', 6.00, true, 18),
    ('bairro-19', 'Malvinas', 7.00, true, 19),
    ('bairro-20', 'Marcos Freire', 20.00, true, 20),
    ('bairro-21', 'Manassu', 10.00, true, 21),
    ('bairro-22', 'Moenda', 6.00, true, 22),
    ('bairro-23', 'Muribeca', 20.00, true, 23),
    ('bairro-24', 'Zumbi do Pacheco', 20.00, true, 24),
    ('bairro-25', 'URs / Ibura', 20.00, true, 25),
    ('bairro-26', 'Pacheco', 20.00, true, 26),
    ('bairro-27', 'Padre Roma', 7.00, true, 27),
    ('bairro-28', 'Quadro', 7.00, true, 28),
    ('bairro-29', 'Vila Natal (Na Portaria)', 7.00, true, 29),
    ('bairro-30', 'Vila Natal (No Apartamento)', 10.00, true, 30),
    ('bairro-31', 'Vila Natal (Condominio sem entrada de moto)', 12.00, true, 31),
    ('bairro-32', 'Retiro', 12.00, true, 32),
    ('bairro-33', 'Sancho', 20.00, true, 33),
    ('bairro-34', 'Santo Aleixo', 7.00, true, 34),
    ('bairro-35', 'Santo Aleixo (Apos Nazareno)', 9.00, true, 35),
    ('bairro-36', 'Socorro (Antes da Granja)', 8.00, true, 36),
    ('bairro-37', 'Socorro (Entrada da Granja)', 10.00, true, 37),
    ('bairro-38', 'Suassuna (Portaria)', 10.00, true, 38),
    ('bairro-39', 'Suassuna (Porta do Apartamento)', 12.00, true, 39),
    ('bairro-40', 'Sucupira', 15.00, true, 40),
    ('bairro-41', 'Vila Piedade', 10.00, true, 41),
    ('bairro-42', 'Vila Rica', 6.00, true, 42),
    ('bairro-43', 'Vila Rica (Porta do Apt das Cohab)', 8.00, true, 43),
    ('bairro-44', 'Santo Antonio (Terminal / Cachimbinho)', 6.00, true, 44),
    ('bairro-45', 'Vista Alegre', 6.00, true, 45),
    ('bairro-46', 'Batoreu', 6.00, true, 46),
    ('bairro-47', 'Gruta do Amor', 9.00, true, 47),
    ('bairro-48', 'Moreno', 20.00, true, 48),
    ('bairro-49', 'Barro', 25.00, true, 49),
    ('bairro-50', 'Areias', 25.00, true, 50),
    ('bairro-51', 'San Martin', 25.00, true, 51),
    ('bairro-52', 'Ipsep', 25.00, true, 52),
    ('bairro-53', 'Varzea', 30.00, true, 53),
    ('bairro-54', 'Imbiribeira', 25.00, true, 54),
    ('bairro-55', 'Centro do Recife', 35.00, true, 55),
    ('bairro-56', 'Afogados', 30.00, true, 56),
    ('bairro-57', 'Cajueiro Seco / Prazeres', 25.00, true, 57),
    ('bairro-58', 'Piedade / Boa Viagem', 30.00, true, 58),
    ('bairro-59', 'Candeias', 35.00, true, 59),
    ('bairro-60', 'Barra de Jangada', 40.00, true, 60)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    delivery_fee = EXCLUDED.delivery_fee;

-- Entregadores
INSERT INTO public.couriers (id, name, phone, is_active)
VALUES
    ('cour-1', 'Entregador 01', '5581999990001', true),
    ('cour-2', 'Entregador 02', '5581999990002', true)
ON CONFLICT (id) DO NOTHING;

-- Produtos / Cardápio Mago Sushi
INSERT INTO public.products (id, category_id, name, description, price, price_p, price_m, price_g, has_sizes, sizes, image_url, is_promo, is_active, is_available, order_index)
VALUES
    ('prod-sunomono-trad', 'cat-especiais', 'Sunomono Tradicional (300g)', 'Salada de Pepino agridoce, salmao e kani.', 25.00, 25.00, 0.00, 0.00, false, '[]'::jsonb, 'logo.jpg', false, true, true, 1),
    ('prod-sunomono-esp', 'cat-especiais', 'Sunomono Especial (300g)', 'Salada de Pepino agridoce, salmao, camarao e kani.', 28.00, 28.00, 0.00, 0.00, false, '[]'::jsonb, 'logo.jpg', false, true, true, 2),
    ('prod-big-hot', 'cat-especiais', 'Big Hot', 'Enrolado de arroz empanado e frito recheado de salmao, camarao e cream cheese.', 25.00, 25.00, 0.00, 0.00, false, '[]'::jsonb, 'logo.jpg', false, true, true, 3),
    ('prod-sushi-burger-misto', 'cat-especiais', 'Sushi Burger Misto', 'Arroz empanado e frito com recheio salmao, camarao, kani e cream cheese.', 28.00, 28.00, 0.00, 0.00, false, '[]'::jsonb, 'logo.jpg', false, true, true, 4),
    ('prod-sushi-burger-salmon', 'cat-especiais', 'Sushi Burger Salmao', 'Arroz empanado e frito com recheio de salmao e cream cheese.', 30.00, 30.00, 0.00, 0.00, false, '[]'::jsonb, 'logo.jpg', false, true, true, 5),
    ('prod-rolinho-romeu', 'cat-especiais', 'Rolinho Romeu e Julieta (dupla)', 'Massa de harumaki, queijo e goiabada frito.', 16.00, 16.00, 0.00, 0.00, false, '[]'::jsonb, 'logo.jpg', false, true, true, 6),
    ('prod-carioca-salmon', 'cat-cariocas', 'Carioca de Salmao (10 und.)', 'Enrolado de arroz, salmao e cream cheese empanado e frito.', 25.00, 25.00, 0.00, 0.00, false, '[]'::jsonb, 'logo.jpg', false, true, true, 1),
    ('prod-carioca-camarao', 'cat-cariocas', 'Carioca de Camarao (10 und.)', 'Enrolado de arroz, camarao cozido, cream cheese empanado e frito.', 24.00, 24.00, 0.00, 0.00, false, '[]'::jsonb, 'logo.jpg', false, true, true, 2),
    ('prod-carioca-camarao-crocante', 'cat-cariocas', 'Carioca de Camarao Crocante (10 und.)', 'Enrolado de arroz, camarao empanado, cream cheese empanado e frito.', 23.00, 23.00, 0.00, 0.00, false, '[]'::jsonb, 'logo.jpg', false, true, true, 3),
    ('prod-carioca-kani', 'cat-cariocas', 'Carioca de Kani (10 und.)', 'Enrolado de arroz, kani, cream cheese empanado e frito.', 20.00, 20.00, 0.00, 0.00, false, '[]'::jsonb, 'logo.jpg', false, true, true, 4),
    ('prod-hosso-salmon', 'cat-hossomakis', 'Hossomaki de Salmao (10 und.)', 'Enrolado de alga por fora e arroz com recheio de salmao.', 25.00, 25.00, 0.00, 0.00, false, '[]'::jsonb, 'logo.jpg', false, true, true, 1),
    ('prod-hosso-camarao', 'cat-hossomakis', 'Hossomaki de Camarao (10 und.)', 'Enrolado de alga por fora e arroz com recheio de camarao.', 25.00, 25.00, 0.00, 0.00, false, '[]'::jsonb, 'logo.jpg', false, true, true, 2),
    ('prod-hosso-kani', 'cat-hossomakis', 'Hossomaki de Kani (10 und.)', 'Enrolado de alga por fora e arroz com recheio de kani.', 25.00, 25.00, 0.00, 0.00, false, '[]'::jsonb, 'logo.jpg', false, true, true, 3),
    ('prod-ura-salmon', 'cat-uramakis', 'Uramaki de Salmao (10 und.)', 'Enrolado de arroz c/ gergelim, salmao e cream cheese.', 25.00, 25.00, 0.00, 0.00, false, '[]'::jsonb, 'logo.jpg', false, true, true, 1),
    ('prod-ura-camarao', 'cat-uramakis', 'Uramaki de Camarao (10 und.)', 'Enrolado de arroz c/ gergelim, camarao cozido e cream cheese.', 23.00, 23.00, 0.00, 0.00, false, '[]'::jsonb, 'logo.jpg', false, true, true, 2),
    ('prod-ura-camarao-emp', 'cat-uramakis', 'Uramaki de Camarao Empanado (10 und.)', 'Enrolado de arroz c/ gergelim, camarao empanado e cream cheese.', 22.00, 22.00, 0.00, 0.00, false, '[]'::jsonb, 'logo.jpg', false, true, true, 3),
    ('prod-ura-kani', 'cat-uramakis', 'Uramaki de Kani (10 und.)', 'Enrolado de arroz c/ gergelim, Kani e cream cheese.', 20.00, 20.00, 0.00, 0.00, false, '[]'::jsonb, 'logo.jpg', false, true, true, 4),
    ('prod-ura-skin', 'cat-uramakis', 'Uramaki de Skin (10 und.)', 'Enrolado de arroz c/ gergelim, Pele de Salmao frita e cream cheese.', 14.00, 14.00, 0.00, 0.00, false, '[]'::jsonb, 'logo.jpg', false, true, true, 5),
    ('prod-ura-salmon-esp', 'cat-uramakis', 'Uramaki de Salmao Especial (10 und.)', 'Enrolado de arroz c/ gergelim, salmao, cream cheese e lamina de Salmao macaricado por cima.', 28.00, 28.00, 0.00, 0.00, false, '[]'::jsonb, 'logo.jpg', false, true, true, 6),
    ('prod-ura-camarao-esp', 'cat-uramakis', 'Uramaki de Camarao Especial (10 und.)', 'Enrolado de arroz c/ gergelim, camarao empanado, cream cheese e lamina de salmao macaricado por cima.', 27.00, 27.00, 0.00, 0.00, false, '[]'::jsonb, 'logo.jpg', false, true, true, 7),
    ('prod-temaki-salmon-nat', 'cat-temakis', 'Temaki de Salmao Natural', 'Arroz, salmao, cream cheese e cebolinha.', 26.00, 26.00, 0.00, 0.00, false, '[]'::jsonb, 'logo.jpg', false, true, true, 1),
    ('prod-temaki-camarao-nat', 'cat-temakis', 'Temaki de Camarao Natural', 'Arroz, camarao cozido, cream cheese e cebolinha.', 23.00, 23.00, 0.00, 0.00, false, '[]'::jsonb, 'logo.jpg', false, true, true, 2),
    ('prod-temaki-camarao-emp', 'cat-temakis', 'Temaki de Camarao Empanado', 'Arroz, camarao empanado, cream cheese e cebolinha.', 24.00, 24.00, 0.00, 0.00, false, '[]'::jsonb, 'logo.jpg', false, true, true, 3),
    ('prod-temaki-kani', 'cat-temakis', 'Temaki de Kani', 'Arroz, Kani, cream cheese e cebolinha.', 18.00, 18.00, 0.00, 0.00, false, '[]'::jsonb, 'logo.jpg', false, true, true, 4),
    ('prod-temaki-skin', 'cat-temakis', 'Temaki de Skin', 'Arroz, Pele de Salmao frita, cream cheese e cebolinha.', 14.00, 14.00, 0.00, 0.00, false, '[]'::jsonb, 'logo.jpg', false, true, true, 5),
    ('prod-temaki-misto', 'cat-temakis', 'Temaki Misto', 'Arroz, Salmao, camarao, Kani, cream cheese e cebolinha.', 24.00, 24.00, 0.00, 0.00, false, '[]'::jsonb, 'logo.jpg', false, true, true, 6),
    ('prod-temaki-hot-salmon', 'cat-temakis', 'Temaki Hot Salmao', 'Arroz, Salmao, cream cheese e cebolinha. Frito.', 25.00, 25.00, 0.00, 0.00, false, '[]'::jsonb, 'logo.jpg', false, true, true, 7),
    ('prod-temaki-hot-camarao', 'cat-temakis', 'Temaki Hot Camarao', 'Arroz, camarao cozido, cream cheese e cebolinha. Frito.', 24.00, 24.00, 0.00, 0.00, false, '[]'::jsonb, 'logo.jpg', false, true, true, 8),
    ('prod-temaki-supremo-misto', 'cat-temakis', 'Temaki Supremo Fire Misto 500g', 'Arroz, salmao, camarao e Kani empanados, cream cheese e cebolinha com Manta de salmao macaricado por cima.', 59.90, 59.90, 0.00, 0.00, false, '[]'::jsonb, 'logo.jpg', false, true, true, 9),
    ('prod-temaki-supremo-camarao', 'cat-temakis', 'Temaki Supremo Fire de Camarao 500g', 'Arroz, camarao empanado, cream cheese e cebolinha com Manta de salmao macaricado por cima.', 59.90, 59.90, 0.00, 0.00, false, '[]'::jsonb, 'logo.jpg', false, true, true, 10),
    ('prod-combo-1', 'cat-combos', 'COMBO 1 (15 pecas)', '5 Niguiri de salmao + 5 Kani queijo + 5 uramaki especial de camarao empanado.', 34.90, 34.90, 0.00, 0.00, false, '[]'::jsonb, 'logo.jpg', false, true, true, 1),
    ('prod-combo-2', 'cat-combos', 'COMBO 2 (1 temaki + 20 pecas)', '10 cariocas salmao e camarao + 10 hot roll salmao e kani + 1 temaki misto frito.', 49.90, 49.90, 0.00, 0.00, false, '[]'::jsonb, 'logo.jpg', false, true, true, 2),
    ('prod-combo-3', 'cat-combos', 'COMBO 3 (2 temakis + 30 pecas)', '10 cariocas misto + 10 Hossomaki misto + 10 uramaki misto + 2 temaki misto natural.', 69.90, 69.90, 0.00, 0.00, false, '[]'::jsonb, 'logo.jpg', false, true, true, 3),
    ('prod-combo-4', 'cat-combos', 'COMBO 4 (40 pecas)', '10 uramakis salmao e camarao + 10 canapes salmao e camarao + 10 cariocas de salmao e camarao + 10 hot roll salmao e camarao.', 59.90, 59.90, 0.00, 0.00, false, '[]'::jsonb, 'logo.jpg', false, true, true, 4),
    ('prod-combo-5', 'cat-combos', 'COMBO 5 (50 pecas)', '20 uramakis misto + 10 Hossomakis misto + 10 cariocas de salmao + 10 Niguiri misto.', 69.90, 69.90, 0.00, 0.00, false, '[]'::jsonb, 'logo.jpg', false, true, true, 5),
    ('prod-barca-especial', 'cat-combos', 'Barca Especial (35 pecas)', '10 uramaki de salmao e camarao + 10 cariocas de salmao e camarao + 6 Niguiri salmao e kani + 4 kani queijo + 3 joy joy + 2 ebi joy.', 65.90, 65.90, 0.00, 0.00, false, '[]'::jsonb, 'logo.jpg', false, true, true, 6),
    ('prod-coca-lata', 'cat-bebidas', 'Coca-Cola Lata 350ml', 'Refrigerante Coca-Cola lata 350ml gelada.', 7.00, 7.00, 0.00, 0.00, false, '[]'::jsonb, 'logo.jpg', false, true, true, 1),
    ('prod-coca-zero-lata', 'cat-bebidas', 'Coca-Cola Zero Lata 350ml', 'Refrigerante Coca-Cola Zero lata 350ml gelada.', 7.00, 7.00, 0.00, 0.00, false, '[]'::jsonb, 'logo.jpg', false, true, true, 2),
    ('prod-guarana-lata', 'cat-bebidas', 'Guarana Antarctica Lata 350ml', 'Refrigerante Guarana Antarctica lata 350ml gelada.', 6.00, 6.00, 0.00, 0.00, false, '[]'::jsonb, 'logo.jpg', false, true, true, 3),
    ('prod-h2o-limoneto', 'cat-bebidas', 'H2O Limoneto 500ml', 'Agua saborizada H2O Limoneto 500ml.', 8.00, 8.00, 0.00, 0.00, false, '[]'::jsonb, 'logo.jpg', false, true, true, 4),
    ('prod-guarana-1l', 'cat-bebidas', 'Guarana Antarctica 1L Pet', 'Refrigerante Guarana Antarctica garrafa 1L.', 10.00, 10.00, 0.00, 0.00, false, '[]'::jsonb, 'logo.jpg', false, true, true, 5),
    ('prod-coca-1l', 'cat-bebidas', 'Coca-Cola 1L Pet', 'Refrigerante Coca-Cola garrafa 1L.', 12.00, 12.00, 0.00, 0.00, false, '[]'::jsonb, 'logo.jpg', false, true, true, 6)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    image_url = EXCLUDED.image_url,
    category_id = EXCLUDED.category_id;
