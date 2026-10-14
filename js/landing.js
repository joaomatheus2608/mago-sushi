/**
 * BOYDEGUSTA - LANDING / PÁGINA DE APRESENTAÇÃO
 * Controla status da loja em tempo real, expansão de horários e compartilhamento.
 */
document.addEventListener('DOMContentLoaded', async () => {
  const dom = {
    welcomeStatusIndicator: document.getElementById('welcomeStatusIndicator'),
    btnToggleHours: document.getElementById('btnToggleHours'),
    hoursAccordionContent: document.getElementById('hoursAccordionContent'),
    hoursArrow: document.getElementById('hoursArrow'),
    btnShareRestaurant: document.getElementById('btnShareRestaurant'),
    appToastNotification: document.getElementById('appToastNotification')
  };

  function showToast(message) {
    if (!dom.appToastNotification) return;
    dom.appToastNotification.innerHTML = `<span>${message}</span>`;
    dom.appToastNotification.classList.add('show');
    setTimeout(() => {
      dom.appToastNotification.classList.remove('show');
    }, 3000);
  }

  // Obter configurações do banco ou fallback
  let settings = null;
  let operatingHours = [];

  try {
    if (window.db) {
      const [s, h] = await Promise.all([
        window.db.getSettings(),
        window.db.getOperatingHours()
      ]);
      settings = s;
      operatingHours = h;
    }
  } catch (e) {
    console.warn('Usando dados locais para horário da loja');
  }

  function updateStoreStatus() {
    let isOpen = true;

    const now = new Date();
    const currentDay = now.getDay();
    const currentMinutes = now.getHours() * 60 + now.getMinutes();

    const isWeekend = (currentDay === 0 || currentDay === 6);
    const dayConfig = (operatingHours || []).find(h => h.day_of_week === currentDay) || {
      is_open: currentDay !== 2, // Terça fechado
      open_time: isWeekend ? '11:00' : '17:30',
      close_time: isWeekend ? '15:00' : '23:00',
      open_time2: isWeekend ? '17:30' : null,
      close_time2: isWeekend ? '23:00' : null
    };

    const checkShift = (openStr, closeStr) => {
      if (!openStr || !closeStr) return false;
      const [oH, oM] = openStr.split(':').map(Number);
      const [cH, cM] = closeStr.split(':').map(Number);
      const oMin = oH * 60 + (oM || 0);
      const cMin = cH * 60 + (cM || 0);
      return currentMinutes >= oMin && currentMinutes <= cMin;
    };

    let activeShift = null;
    if (settings && settings.store_status_mode === 'force_open') {
      isOpen = true;
    } else if (settings && settings.store_status_mode === 'force_closed') {
      isOpen = false;
    } else {
      if (!dayConfig.is_open) {
        isOpen = false;
      } else {
        const inShift1 = checkShift(dayConfig.open_time, dayConfig.close_time);
        const inShift2 = checkShift(dayConfig.open_time2, dayConfig.close_time2);
        isOpen = inShift1 || inShift2;
        if (inShift1) activeShift = (dayConfig.open_time === '11:00') ? 'lunch' : 'dinner';
        if (inShift2) activeShift = 'dinner';
      }
    }

    if (dom.welcomeStatusIndicator) {
      dom.welcomeStatusIndicator.className = `welcome-status-text ${isOpen ? 'is-open' : 'is-closed'}`;
      const isDayClosed = !dayConfig.is_open;
      let statusText = '';
      if (isOpen) {
        if (activeShift === 'lunch') {
          statusText = '<i class="fi fi-sr-circle" style="color: #22c55e; font-size: 0.75em;"></i> Aberto agora • Almoço até 15:00';
        } else {
          statusText = '<i class="fi fi-sr-circle" style="color: #22c55e; font-size: 0.75em;"></i> Aberto agora • Fecha às 23:00';
        }
      } else if (isDayClosed) {
        statusText = '<i class="fi fi-sr-circle" style="color: #ef4444; font-size: 0.75em;"></i> Fechado hoje (Terça-feira) • Abre Quarta às 17:30';
      } else if (isWeekend && currentMinutes < 11 * 60) {
        statusText = '<i class="fi fi-sr-circle" style="color: #ef4444; font-size: 0.75em;"></i> Fechado • Abre hoje para o almoço às 11:00';
      } else if (isWeekend && currentMinutes >= 15 * 60 && currentMinutes < (17 * 60 + 30)) {
        statusText = '<i class="fi fi-sr-circle" style="color: #ef4444; font-size: 0.75em;"></i> Fechado agora • Reabre hoje às 17:30';
      } else if (currentMinutes < (17 * 60 + 30)) {
        statusText = '<i class="fi fi-sr-circle" style="color: #ef4444; font-size: 0.75em;"></i> Fechado • Abre hoje às 17:30';
      } else {
        statusText = '<i class="fi fi-sr-circle" style="color: #ef4444; font-size: 0.75em;"></i> Fechado agora • Abre no próximo horário';
      }
      dom.welcomeStatusIndicator.innerHTML = `
        <span class="status-indicator-dot"></span>
        <span>${statusText}</span>
      `;
    }
  }

  updateStoreStatus();
  setInterval(updateStoreStatus, 60000);

  // Toggle do menu de horários
  if (dom.btnToggleHours && dom.hoursAccordionContent) {
    dom.btnToggleHours.addEventListener('click', () => {
      const isShown = dom.hoursAccordionContent.style.display === 'block';
      dom.hoursAccordionContent.style.display = isShown ? 'none' : 'block';
      if (dom.hoursArrow) {
        dom.hoursArrow.textContent = isShown ? '▾' : '▴';
      }
    });
  }

  // Compartilhar cardápio
  if (dom.btnShareRestaurant) {
    dom.btnShareRestaurant.addEventListener('click', async () => {
      const shareData = {
        title: 'Mago Sushi',
        text: 'Confira o cardápio e faça seu pedido no Mago Sushi Delivery!',
        url: window.location.href
      };
      if (navigator.share) {
        try {
          await navigator.share(shareData);
        } catch (err) {}
      } else {
        try {
          await navigator.clipboard.writeText(window.location.href);
          showToast('<i class="fi fi-sr-check-circle"></i> Link copiado para a área de transferência!');
        } catch {
          showToast('<i class="fi fi-sr-check-circle"></i> Link: ' + window.location.href);
        }
      }
    });
  }
});
