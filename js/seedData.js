// ========================================================
// MAGO SUSHI - DADOS OFICIAIS DO CARDAPIO & SISTEMA
// ========================================================

const INITIAL_SETTINGS = {
  id: "store-settings",
  name: "Mago Sushi",
  slogan: "O melhor sushi delivery da regiao!",
  address: "Delivery de Sushi Artesanal",
  whatsapp: "5581991421295",
  instagram: "@magosushidelivery",
  delivery_fee: 5.00,
  min_order_value: 20.00,
  store_status_mode: "auto",
  closed_message: "Estamos fechados no momento. Horário: Quarta a Segunda das 17:30 às 23:00 (Terça-feira fechado). Sábado e Domingo almoço das 11:00 às 15:00 e jantar das 17:30 às 23:00.",
  pix_key: "5581991421295",
  pix_type: "Telefone",
  pix_beneficiary: "Mago Sushi"
};

const INITIAL_OPERATING_HOURS = [
  { day_of_week: 0, day_name: "Domingo", open_time: "11:00", close_time: "15:00", open_time2: "17:30", close_time2: "23:00", is_open: true },
  { day_of_week: 1, day_name: "Segunda-feira", open_time: "17:30", close_time: "23:00", open_time2: null, close_time2: null, is_open: true },
  { day_of_week: 2, day_name: "Terca-feira", open_time: "17:30", close_time: "23:00", open_time2: null, close_time2: null, is_open: false },
  { day_of_week: 3, day_name: "Quarta-feira", open_time: "17:30", close_time: "23:00", open_time2: null, close_time2: null, is_open: true },
  { day_of_week: 4, day_name: "Quinta-feira", open_time: "17:30", close_time: "23:00", open_time2: null, close_time2: null, is_open: true },
  { day_of_week: 5, day_name: "Sexta-feira", open_time: "17:30", close_time: "23:00", open_time2: null, close_time2: null, is_open: true },
  { day_of_week: 6, day_name: "Sabado", open_time: "11:00", close_time: "15:00", open_time2: "17:30", close_time2: "23:00", is_open: true }
];

const INITIAL_CATEGORIES = [
  { id: "cat-especiais", name: "Especiais", slug: "especiais", order_index: 1, is_active: true },
  { id: "cat-cariocas", name: "Cariocas", slug: "cariocas", order_index: 2, is_active: true },
  { id: "cat-hossomakis", name: "Hossomakis", slug: "hossomakis", order_index: 3, is_active: true },
  { id: "cat-uramakis", name: "Uramakis", slug: "uramakis", order_index: 4, is_active: true },
  { id: "cat-temakis", name: "Temakis", slug: "temakis", order_index: 5, is_active: true },
  { id: "cat-combos", name: "Combos", slug: "combos", order_index: 6, is_active: true },
  { id: "cat-bebidas", name: "Bebidas", slug: "bebidas", order_index: 7, is_active: true }
];

const INITIAL_OPTIONALS = [
  { id: "opt-shoyu", name: "Shoyu", price: 2.00, is_active: true, target: "all", applicable_category_ids: [], order_index: 1 },
  { id: "opt-teriaki", name: "Teriaki", price: 2.00, is_active: true, target: "all", applicable_category_ids: [], order_index: 2 },
  { id: "opt-wasabi", name: "Wasabi", price: 2.00, is_active: true, target: "all", applicable_category_ids: [], order_index: 3 },
  { id: "opt-gengibre", name: "Gengibre", price: 2.00, is_active: true, target: "all", applicable_category_ids: [], order_index: 4 },
  { id: "opt-cream-cheese", name: "Cream Cheese", price: 3.00, is_active: true, target: "all", applicable_category_ids: [], order_index: 5 }
];

const INITIAL_PROMOTIONS = [];

const INITIAL_NEIGHBORHOODS = [
  { id: "bairro-1", name: "Alphaville", delivery_fee: 15.00, is_active: true, order_index: 1 },
  { id: "bairro-2", name: "Alto da Fabrica", delivery_fee: 6.00, is_active: true, order_index: 2 },
  { id: "bairro-3", name: "Alto do Vento", delivery_fee: 15.00, is_active: true, order_index: 3 },
  { id: "bairro-4", name: "Bulhoes", delivery_fee: 6.00, is_active: true, order_index: 4 },
  { id: "bairro-5", name: "Cascata", delivery_fee: 7.00, is_active: true, order_index: 5 },
  { id: "bairro-6", name: "Coqueiral", delivery_fee: 20.00, is_active: true, order_index: 6 },
  { id: "bairro-7", name: "Cavaleiro (Antes da Estacao)", delivery_fee: 15.00, is_active: true, order_index: 7 },
  { id: "bairro-8", name: "Cavaleiro (Bairros)", delivery_fee: 20.00, is_active: true, order_index: 8 },
  { id: "bairro-9", name: "Curado 1 / 2 / 3 / 4", delivery_fee: 20.00, is_active: true, order_index: 9 },
  { id: "bairro-10", name: "Dois Carneiros (Ate Fund. Bradesco / Yapoatam)", delivery_fee: 15.00, is_active: true, order_index: 10 },
  { id: "bairro-11", name: "Dois Carneiros (Apos Fund. Bradesco)", delivery_fee: 20.00, is_active: true, order_index: 11 },
  { id: "bairro-12", name: "Engenho Velho", delivery_fee: 7.00, is_active: true, order_index: 12 },
  { id: "bairro-13", name: "Floriano", delivery_fee: 10.00, is_active: true, order_index: 13 },
  { id: "bairro-14", name: "Lote 56 (Terminal)", delivery_fee: 7.00, is_active: true, order_index: 14 },
  { id: "bairro-15", name: "Lote 56 (Casinhas)", delivery_fee: 10.00, is_active: true, order_index: 15 },
  { id: "bairro-16", name: "Lote 92", delivery_fee: 7.00, is_active: true, order_index: 16 },
  { id: "bairro-17", name: "Lote 92 (Colonia dos Padres)", delivery_fee: 8.00, is_active: true, order_index: 17 },
  { id: "bairro-18", name: "Tenda", delivery_fee: 6.00, is_active: true, order_index: 18 },
  { id: "bairro-19", name: "Malvinas", delivery_fee: 7.00, is_active: true, order_index: 19 },
  { id: "bairro-20", name: "Marcos Freire", delivery_fee: 20.00, is_active: true, order_index: 20 },
  { id: "bairro-21", name: "Manassu", delivery_fee: 10.00, is_active: true, order_index: 21 },
  { id: "bairro-22", name: "Moenda", delivery_fee: 6.00, is_active: true, order_index: 22 },
  { id: "bairro-23", name: "Muribeca", delivery_fee: 20.00, is_active: true, order_index: 23 },
  { id: "bairro-24", name: "Zumbi do Pacheco", delivery_fee: 20.00, is_active: true, order_index: 24 },
  { id: "bairro-25", name: "URs / Ibura", delivery_fee: 20.00, is_active: true, order_index: 25 },
  { id: "bairro-26", name: "Pacheco", delivery_fee: 20.00, is_active: true, order_index: 26 },
  { id: "bairro-27", name: "Padre Roma", delivery_fee: 7.00, is_active: true, order_index: 27 },
  { id: "bairro-28", name: "Quadro", delivery_fee: 7.00, is_active: true, order_index: 28 },
  { id: "bairro-29", name: "Vila Natal (Na Portaria)", delivery_fee: 7.00, is_active: true, order_index: 29 },
  { id: "bairro-30", name: "Vila Natal (No Apartamento)", delivery_fee: 10.00, is_active: true, order_index: 30 },
  { id: "bairro-31", name: "Vila Natal (Condominio sem entrada de moto)", delivery_fee: 12.00, is_active: true, order_index: 31 },
  { id: "bairro-32", name: "Retiro", delivery_fee: 12.00, is_active: true, order_index: 32 },
  { id: "bairro-33", name: "Sancho", delivery_fee: 20.00, is_active: true, order_index: 33 },
  { id: "bairro-34", name: "Santo Aleixo", delivery_fee: 7.00, is_active: true, order_index: 34 },
  { id: "bairro-35", name: "Santo Aleixo (Apos Nazareno)", delivery_fee: 9.00, is_active: true, order_index: 35 },
  { id: "bairro-36", name: "Socorro (Antes da Granja)", delivery_fee: 8.00, is_active: true, order_index: 36 },
  { id: "bairro-37", name: "Socorro (Entrada da Granja)", delivery_fee: 10.00, is_active: true, order_index: 37 },
  { id: "bairro-38", name: "Suassuna (Portaria)", delivery_fee: 10.00, is_active: true, order_index: 38 },
  { id: "bairro-39", name: "Suassuna (Porta do Apartamento)", delivery_fee: 12.00, is_active: true, order_index: 39 },
  { id: "bairro-40", name: "Sucupira", delivery_fee: 15.00, is_active: true, order_index: 40 },
  { id: "bairro-41", name: "Vila Piedade", delivery_fee: 10.00, is_active: true, order_index: 41 },
  { id: "bairro-42", name: "Vila Rica", delivery_fee: 6.00, is_active: true, order_index: 42 },
  { id: "bairro-43", name: "Vila Rica (Porta do Apt das Cohab)", delivery_fee: 8.00, is_active: true, order_index: 43 },
  { id: "bairro-44", name: "Santo Antonio (Terminal / Cachimbinho)", delivery_fee: 6.00, is_active: true, order_index: 44 },
  { id: "bairro-45", name: "Vista Alegre", delivery_fee: 6.00, is_active: true, order_index: 45 },
  { id: "bairro-46", name: "Batoreu", delivery_fee: 6.00, is_active: true, order_index: 46 },
  { id: "bairro-47", name: "Gruta do Amor", delivery_fee: 9.00, is_active: true, order_index: 47 },
  { id: "bairro-48", name: "Moreno", delivery_fee: 20.00, is_active: true, order_index: 48 },
  { id: "bairro-49", name: "Barro", delivery_fee: 25.00, is_active: true, order_index: 49 },
  { id: "bairro-50", name: "Areias", delivery_fee: 25.00, is_active: true, order_index: 50 },
  { id: "bairro-51", name: "San Martin", delivery_fee: 25.00, is_active: true, order_index: 51 },
  { id: "bairro-52", name: "Ipsep", delivery_fee: 25.00, is_active: true, order_index: 52 },
  { id: "bairro-53", name: "Varzea", delivery_fee: 30.00, is_active: true, order_index: 53 },
  { id: "bairro-54", name: "Imbiribeira", delivery_fee: 25.00, is_active: true, order_index: 54 },
  { id: "bairro-55", name: "Centro do Recife", delivery_fee: 35.00, is_active: true, order_index: 55 },
  { id: "bairro-56", name: "Afogados", delivery_fee: 30.00, is_active: true, order_index: 56 },
  { id: "bairro-57", name: "Cajueiro Seco / Prazeres", delivery_fee: 25.00, is_active: true, order_index: 57 },
  { id: "bairro-58", name: "Piedade / Boa Viagem", delivery_fee: 30.00, is_active: true, order_index: 58 },
  { id: "bairro-59", name: "Candeias", delivery_fee: 35.00, is_active: true, order_index: 59 },
  { id: "bairro-60", name: "Barra de Jangada", delivery_fee: 40.00, is_active: true, order_index: 60 }
];

const INITIAL_COURIERS = [
  { id: "cour-1", name: "Entregador 01", phone: "5581999990001", is_active: true },
  { id: "cour-2", name: "Entregador 02", phone: "5581999990002", is_active: true }
];

const INITIAL_PRODUCTS = [

  // ==========================================
  // 1. ESPECIAIS
  // ==========================================
  {
    id: "prod-sunomono-trad",
    category_id: "cat-especiais",
    name: "Sunomono Tradicional (300g)",
    description: "Salada de Pepino agridoce, salmao e kani.",
    price: 25.00,
    image_url: "logo.jpg",
    is_promo: false,
    is_active: true,
    is_available: true,
    order_index: 1
  },
  {
    id: "prod-sunomono-esp",
    category_id: "cat-especiais",
    name: "Sunomono Especial (300g)",
    description: "Salada de Pepino agridoce, salmao, camarao e kani.",
    price: 28.00,
    image_url: "logo.jpg",
    is_promo: false,
    is_active: true,
    is_available: true,
    order_index: 2
  },
  {
    id: "prod-big-hot",
    category_id: "cat-especiais",
    name: "Big Hot",
    description: "Enrolado de arroz empanado e frito recheado de salmao, camarao e cream cheese.",
    price: 25.00,
    image_url: "logo.jpg",
    is_promo: false,
    is_active: true,
    is_available: true,
    order_index: 3
  },
  {
    id: "prod-sushi-burger-misto",
    category_id: "cat-especiais",
    name: "Sushi Burger Misto",
    description: "Arroz empanado e frito com recheio salmao, camarao, kani e cream cheese.",
    price: 28.00,
    image_url: "logo.jpg",
    is_promo: false,
    is_active: true,
    is_available: true,
    order_index: 4
  },
  {
    id: "prod-sushi-burger-salmon",
    category_id: "cat-especiais",
    name: "Sushi Burger Salmao",
    description: "Arroz empanado e frito com recheio de salmao e cream cheese.",
    price: 30.00,
    image_url: "logo.jpg",
    is_promo: false,
    is_active: true,
    is_available: true,
    order_index: 5
  },
  {
    id: "prod-rolinho-romeu",
    category_id: "cat-especiais",
    name: "Rolinho Romeu e Julieta (dupla)",
    description: "Massa de harumaki, queijo e goiabada frito.",
    price: 16.00,
    image_url: "logo.jpg",
    is_promo: false,
    is_active: true,
    is_available: true,
    order_index: 6
  },

  // ==========================================
  // 2. CARIOCAS (10 unidades cada)
  // ==========================================
  {
    id: "prod-carioca-salmon",
    category_id: "cat-cariocas",
    name: "Carioca de Salmao (10 und.)",
    description: "Enrolado de arroz, salmao e cream cheese empanado e frito.",
    price: 25.00,
    image_url: "logo.jpg",
    is_promo: false,
    is_active: true,
    is_available: true,
    order_index: 1
  },
  {
    id: "prod-carioca-camarao",
    category_id: "cat-cariocas",
    name: "Carioca de Camarao (10 und.)",
    description: "Enrolado de arroz, camarao cozido, cream cheese empanado e frito.",
    price: 24.00,
    image_url: "logo.jpg",
    is_promo: false,
    is_active: true,
    is_available: true,
    order_index: 2
  },
  {
    id: "prod-carioca-camarao-crocante",
    category_id: "cat-cariocas",
    name: "Carioca de Camarao Crocante (10 und.)",
    description: "Enrolado de arroz, camarao empanado, cream cheese empanado e frito.",
    price: 23.00,
    image_url: "logo.jpg",
    is_promo: false,
    is_active: true,
    is_available: true,
    order_index: 3
  },
  {
    id: "prod-carioca-kani",
    category_id: "cat-cariocas",
    name: "Carioca de Kani (10 und.)",
    description: "Enrolado de arroz, kani, cream cheese empanado e frito.",
    price: 20.00,
    image_url: "logo.jpg",
    is_promo: false,
    is_active: true,
    is_available: true,
    order_index: 4
  },

  // ==========================================
  // 3. HOSSOMAKIS (10 unidades cada)
  // ==========================================
  {
    id: "prod-hosso-salmon",
    category_id: "cat-hossomakis",
    name: "Hossomaki de Salmao (10 und.)",
    description: "Enrolado de alga por fora e arroz com recheio de salmao.",
    price: 25.00,
    image_url: "logo.jpg",
    is_promo: false,
    is_active: true,
    is_available: true,
    order_index: 1
  },
  {
    id: "prod-hosso-camarao",
    category_id: "cat-hossomakis",
    name: "Hossomaki de Camarao (10 und.)",
    description: "Enrolado de alga por fora e arroz com recheio de camarao.",
    price: 25.00,
    image_url: "logo.jpg",
    is_promo: false,
    is_active: true,
    is_available: true,
    order_index: 2
  },
  {
    id: "prod-hosso-kani",
    category_id: "cat-hossomakis",
    name: "Hossomaki de Kani (10 und.)",
    description: "Enrolado de alga por fora e arroz com recheio de kani.",
    price: 25.00,
    image_url: "logo.jpg",
    is_promo: false,
    is_active: true,
    is_available: true,
    order_index: 3
  },

  // ==========================================
  // 4. URAMAKIS (10 unidades cada)
  // ==========================================
  {
    id: "prod-ura-salmon",
    category_id: "cat-uramakis",
    name: "Uramaki de Salmao (10 und.)",
    description: "Enrolado de arroz c/ gergelim, salmao e cream cheese.",
    price: 25.00,
    image_url: "logo.jpg",
    is_promo: false,
    is_active: true,
    is_available: true,
    order_index: 1
  },
  {
    id: "prod-ura-camarao",
    category_id: "cat-uramakis",
    name: "Uramaki de Camarao (10 und.)",
    description: "Enrolado de arroz c/ gergelim, camarao cozido e cream cheese.",
    price: 23.00,
    image_url: "logo.jpg",
    is_promo: false,
    is_active: true,
    is_available: true,
    order_index: 2
  },
  {
    id: "prod-ura-camarao-emp",
    category_id: "cat-uramakis",
    name: "Uramaki de Camarao Empanado (10 und.)",
    description: "Enrolado de arroz c/ gergelim, camarao empanado e cream cheese.",
    price: 22.00,
    image_url: "logo.jpg",
    is_promo: false,
    is_active: true,
    is_available: true,
    order_index: 3
  },
  {
    id: "prod-ura-kani",
    category_id: "cat-uramakis",
    name: "Uramaki de Kani (10 und.)",
    description: "Enrolado de arroz c/ gergelim, Kani e cream cheese.",
    price: 20.00,
    image_url: "logo.jpg",
    is_promo: false,
    is_active: true,
    is_available: true,
    order_index: 4
  },
  {
    id: "prod-ura-skin",
    category_id: "cat-uramakis",
    name: "Uramaki de Skin (10 und.)",
    description: "Enrolado de arroz c/ gergelim, Pele de Salmao frita e cream cheese.",
    price: 14.00,
    image_url: "logo.jpg",
    is_promo: false,
    is_active: true,
    is_available: true,
    order_index: 5
  },
  {
    id: "prod-ura-salmon-esp",
    category_id: "cat-uramakis",
    name: "Uramaki de Salmao Especial (10 und.)",
    description: "Enrolado de arroz c/ gergelim, salmao, cream cheese e lamina de Salmao macaricado por cima.",
    price: 28.00,
    image_url: "logo.jpg",
    is_promo: false,
    is_active: true,
    is_available: true,
    order_index: 6
  },
  {
    id: "prod-ura-camarao-esp",
    category_id: "cat-uramakis",
    name: "Uramaki de Camarao Especial (10 und.)",
    description: "Enrolado de arroz c/ gergelim, camarao empanado, cream cheese e lamina de salmao macaricado por cima.",
    price: 27.00,
    image_url: "logo.jpg",
    is_promo: false,
    is_active: true,
    is_available: true,
    order_index: 7
  },

  // ==========================================
  // 5. TEMAKIS
  // ==========================================
  {
    id: "prod-temaki-salmon-nat",
    category_id: "cat-temakis",
    name: "Temaki de Salmao Natural",
    description: "Arroz, salmao, cream cheese e cebolinha.",
    price: 26.00,
    image_url: "logo.jpg",
    is_promo: false,
    is_active: true,
    is_available: true,
    order_index: 1
  },
  {
    id: "prod-temaki-camarao-nat",
    category_id: "cat-temakis",
    name: "Temaki de Camarao Natural",
    description: "Arroz, camarao cozido, cream cheese e cebolinha.",
    price: 23.00,
    image_url: "logo.jpg",
    is_promo: false,
    is_active: true,
    is_available: true,
    order_index: 2
  },
  {
    id: "prod-temaki-camarao-emp",
    category_id: "cat-temakis",
    name: "Temaki de Camarao Empanado",
    description: "Arroz, camarao empanado, cream cheese e cebolinha.",
    price: 24.00,
    image_url: "logo.jpg",
    is_promo: false,
    is_active: true,
    is_available: true,
    order_index: 3
  },
  {
    id: "prod-temaki-kani",
    category_id: "cat-temakis",
    name: "Temaki de Kani",
    description: "Arroz, Kani, cream cheese e cebolinha.",
    price: 18.00,
    image_url: "logo.jpg",
    is_promo: false,
    is_active: true,
    is_available: true,
    order_index: 4
  },
  {
    id: "prod-temaki-skin",
    category_id: "cat-temakis",
    name: "Temaki de Skin",
    description: "Arroz, Pele de Salmao frita, cream cheese e cebolinha.",
    price: 14.00,
    image_url: "logo.jpg",
    is_promo: false,
    is_active: true,
    is_available: true,
    order_index: 5
  },
  {
    id: "prod-temaki-misto",
    category_id: "cat-temakis",
    name: "Temaki Misto",
    description: "Arroz, Salmao, camarao, Kani, cream cheese e cebolinha.",
    price: 24.00,
    image_url: "logo.jpg",
    is_promo: false,
    is_active: true,
    is_available: true,
    order_index: 6
  },
  {
    id: "prod-temaki-hot-salmon",
    category_id: "cat-temakis",
    name: "Temaki Hot Salmao",
    description: "Arroz, Salmao, cream cheese e cebolinha. Frito.",
    price: 25.00,
    image_url: "logo.jpg",
    is_promo: false,
    is_active: true,
    is_available: true,
    order_index: 7
  },
  {
    id: "prod-temaki-hot-camarao",
    category_id: "cat-temakis",
    name: "Temaki Hot Camarao",
    description: "Arroz, camarao cozido, cream cheese e cebolinha. Frito.",
    price: 24.00,
    image_url: "logo.jpg",
    is_promo: false,
    is_active: true,
    is_available: true,
    order_index: 8
  },
  {
    id: "prod-temaki-supremo-misto",
    category_id: "cat-temakis",
    name: "Temaki Supremo Fire Misto 500g",
    description: "Arroz, salmao, camarao e Kani empanados, cream cheese e cebolinha com Manta de salmao macaricado por cima.",
    price: 59.90,
    image_url: "logo.jpg",
    is_promo: false,
    is_active: true,
    is_available: true,
    order_index: 9
  },
  {
    id: "prod-temaki-supremo-camarao",
    category_id: "cat-temakis",
    name: "Temaki Supremo Fire de Camarao 500g",
    description: "Arroz, camarao empanado, cream cheese e cebolinha com Manta de salmao macaricado por cima.",
    price: 59.90,
    image_url: "logo.jpg",
    is_promo: false,
    is_active: true,
    is_available: true,
    order_index: 10
  },

  // ==========================================
  // 6. COMBOS
  // ==========================================
  {
    id: "prod-combo-1",
    category_id: "cat-combos",
    name: "COMBO 1 (15 pecas)",
    description: "5 Niguiri de salmao + 5 Kani queijo + 5 uramaki especial de camarao empanado.",
    price: 34.90,
    image_url: "logo.jpg",
    is_promo: false,
    is_active: true,
    is_available: true,
    order_index: 1
  },
  {
    id: "prod-combo-2",
    category_id: "cat-combos",
    name: "COMBO 2 (1 temaki + 20 pecas)",
    description: "10 cariocas salmao e camarao + 10 hot roll salmao e kani + 1 temaki misto frito.",
    price: 49.90,
    image_url: "logo.jpg",
    is_promo: false,
    is_active: true,
    is_available: true,
    order_index: 2
  },
  {
    id: "prod-combo-3",
    category_id: "cat-combos",
    name: "COMBO 3 (2 temakis + 30 pecas)",
    description: "10 cariocas misto + 10 Hossomaki misto + 10 uramaki misto + 2 temaki misto natural.",
    price: 69.90,
    image_url: "logo.jpg",
    is_promo: false,
    is_active: true,
    is_available: true,
    order_index: 3
  },
  {
    id: "prod-combo-4",
    category_id: "cat-combos",
    name: "COMBO 4 (40 pecas)",
    description: "10 uramakis salmao e camarao + 10 canapes salmao e camarao + 10 cariocas de salmao e camarao + 10 hot roll salmao e camarao.",
    price: 59.90,
    image_url: "logo.jpg",
    is_promo: false,
    is_active: true,
    is_available: true,
    order_index: 4
  },
  {
    id: "prod-combo-5",
    category_id: "cat-combos",
    name: "COMBO 5 (50 pecas)",
    description: "20 uramakis misto + 10 Hossomakis misto + 10 cariocas de salmao + 10 Niguiri misto.",
    price: 69.90,
    image_url: "logo.jpg",
    is_promo: false,
    is_active: true,
    is_available: true,
    order_index: 5
  },
  {
    id: "prod-barca-especial",
    category_id: "cat-combos",
    name: "Barca Especial (35 pecas)",
    description: "10 uramaki de salmao e camarao + 10 cariocas de salmao e camarao + 6 Niguiri salmao e kani + 4 kani queijo + 3 joy joy + 2 ebi joy.",
    price: 65.90,
    image_url: "logo.jpg",
    is_promo: false,
    is_active: true,
    is_available: true,
    order_index: 6
  },

  // ==========================================
  // 7. BEBIDAS
  // ==========================================
  {
    id: "prod-coca-lata",
    category_id: "cat-bebidas",
    name: "Coca-Cola Lata 350ml",
    description: "Refrigerante Coca-Cola lata 350ml gelada.",
    price: 7.00,
    image_url: "logo.jpg",
    is_promo: false,
    is_active: true,
    is_available: true,
    order_index: 1
  },
  {
    id: "prod-coca-zero-lata",
    category_id: "cat-bebidas",
    name: "Coca-Cola Zero Lata 350ml",
    description: "Refrigerante Coca-Cola Zero lata 350ml gelada.",
    price: 7.00,
    image_url: "logo.jpg",
    is_promo: false,
    is_active: true,
    is_available: true,
    order_index: 2
  },
  {
    id: "prod-guarana-lata",
    category_id: "cat-bebidas",
    name: "Guarana Antarctica Lata 350ml",
    description: "Refrigerante Guarana Antarctica lata 350ml gelada.",
    price: 6.00,
    image_url: "logo.jpg",
    is_promo: false,
    is_active: true,
    is_available: true,
    order_index: 3
  },
  {
    id: "prod-h2o-limoneto",
    category_id: "cat-bebidas",
    name: "H2O Limoneto 500ml",
    description: "Agua saborizada H2O Limoneto 500ml.",
    price: 8.00,
    image_url: "logo.jpg",
    is_promo: false,
    is_active: true,
    is_available: true,
    order_index: 4
  },
  {
    id: "prod-guarana-1l",
    category_id: "cat-bebidas",
    name: "Guarana Antarctica 1L Pet",
    description: "Refrigerante Guarana Antarctica garrafa 1L.",
    price: 10.00,
    image_url: "logo.jpg",
    is_promo: false,
    is_active: true,
    is_available: true,
    order_index: 5
  },
  {
    id: "prod-coca-1l",
    category_id: "cat-bebidas",
    name: "Coca-Cola 1L Pet",
    description: "Refrigerante Coca-Cola garrafa 1L.",
    price: 12.00,
    image_url: "logo.jpg",
    is_promo: false,
    is_active: true,
    is_available: true,
    order_index: 6
  }
];

// Exporta globalmente
window.INITIAL_SETTINGS = INITIAL_SETTINGS;
window.INITIAL_OPERATING_HOURS = INITIAL_OPERATING_HOURS;
window.INITIAL_CATEGORIES = INITIAL_CATEGORIES;
window.INITIAL_PRODUCTS = INITIAL_PRODUCTS;
window.INITIAL_OPTIONALS = INITIAL_OPTIONALS;
window.INITIAL_PROMOTIONS = INITIAL_PROMOTIONS;
window.INITIAL_NEIGHBORHOODS = INITIAL_NEIGHBORHOODS;
window.INITIAL_COURIERS = INITIAL_COURIERS;
