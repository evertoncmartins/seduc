/* =========================================
   1. NAVEGAÇÃO SPA
========================================= */
const landingView = document.getElementById('landing-view');
const studioView = document.getElementById('studio-view');

function openStudio() {
    landingView.classList.add('hidden');
    studioView.classList.remove('hidden');
    window.scrollTo(0, 0);
}

function closeStudio() {
    studioView.classList.add('hidden');
    landingView.classList.remove('hidden');
    window.scrollTo(0, 0);
}

/* =========================================
   2. SISTEMA DE TEMA (DARK/LIGHT/SYSTEM)
========================================= */
const html = document.documentElement;
// Botões que abrem o menu (LP, App Header, Sidebar)
const themeToggles = document.querySelectorAll('.theme-toggle'); 
// Menus dropdown
const themeMenus = document.querySelectorAll('.theme-menu');
// Opções dentro dos menus
const themeOptions = document.querySelectorAll('.theme-option');

// Função para aplicar o tema
function applyTheme(theme) {
    // 1. Remove qualquer classe anterior
    html.removeAttribute('data-theme');
    
    // 2. Lógica de aplicação
    if (theme === 'dark') {
        html.setAttribute('data-theme', 'dark');
        updateIcons('dark');
    } else if (theme === 'light') {
        html.removeAttribute('data-theme'); // Padrão é light no CSS
        updateIcons('light');
    } else if (theme === 'system') {
        // Verifica preferência do sistema
        const systemDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
        if (systemDark) html.setAttribute('data-theme', 'dark');
        else html.removeAttribute('data-theme');
        updateIcons('system');
    }

    // 3. Atualiza estado ativo no menu
    themeOptions.forEach(opt => {
        if(opt.dataset.theme === theme) opt.classList.add('active');
        else opt.classList.remove('active');
    });

    // 4. Salva no LocalStorage
    localStorage.setItem('theme', theme);
}

// Atualiza o ícone do botão principal baseado na escolha
function updateIcons(currentTheme) {
    const iconsMap = {
        'light': 'ph-sun',
        'dark': 'ph-moon',
        'system': 'ph-desktop'
    };
    
    // Se for system, precisamos saber qual ícone mostrar visualmente (sol ou lua) ou mostrar o computador?
    // O pedido mostra ícones específicos no menu. No botão principal, vamos manter o ícone do estado atual.
    
    let iconClass = iconsMap[currentTheme];
    
    document.querySelectorAll('.theme-toggle i').forEach(icon => {
        // Remove classes antigas de ícone
        icon.classList.remove('ph-sun', 'ph-moon', 'ph-desktop', 'ph-sun-dim');
        icon.classList.add(iconClass);
    });
}

// Inicialização
const savedTheme = localStorage.getItem('theme') || 'system';
applyTheme(savedTheme);

// Listener para mudanças no sistema (caso esteja em 'system')
window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', e => {
    if (localStorage.getItem('theme') === 'system') {
        applyTheme('system');
    }
});

// Abrir/Fechar Menu Dropdown
themeToggles.forEach(toggle => {
    toggle.addEventListener('click', (e) => {
        e.stopPropagation(); // Evita fechar imediatamente
        // Encontra o menu irmão deste botão
        const menu = toggle.nextElementSibling; 
        
        // Fecha outros abertos
        themeMenus.forEach(m => {
            if(m !== menu) m.classList.remove('active');
        });

        if(menu) menu.classList.toggle('active');
    });
});

// Clique nas opções
themeOptions.forEach(opt => {
    opt.addEventListener('click', () => {
        applyTheme(opt.dataset.theme);
        // Fecha todos os menus
        themeMenus.forEach(m => m.classList.remove('active'));
    });
});

// Fechar ao clicar fora
document.addEventListener('click', () => {
    themeMenus.forEach(m => m.classList.remove('active'));
});


/* =========================================
   3. ACCORDION FAQ
========================================= */
document.querySelectorAll('.faq-question').forEach(btn => {
    btn.addEventListener('click', () => {
        const item = btn.parentElement;
        item.classList.toggle('active');
        document.querySelectorAll('.faq-item').forEach(other => {
            if(other !== item) other.classList.remove('active');
        });
    });
});

/* =========================================
   4. CARROSSEL DE DEPOIMENTOS
========================================= */
const track = document.querySelector('.carousel-track');
if (track) {
    const slides = Array.from(track.children);
    const nextButton = document.querySelector('.next-btn');
    const prevButton = document.querySelector('.prev-btn');
    const dotsNav = document.querySelector('.carousel-nav');
    const dots = Array.from(dotsNav.children);

    const slideWidth = slides[0].getBoundingClientRect().width;

    const setSlidePosition = (slide, index) => {
        slide.style.left = slideWidth * index + 'px';
    };
    slides.forEach(setSlidePosition);

    const moveToSlide = (track, currentSlide, targetSlide) => {
        track.style.transform = 'translateX(-' + targetSlide.style.left + ')';
        currentSlide.classList.remove('current-slide');
        targetSlide.classList.add('current-slide');
    };

    const updateDots = (currentDot, targetDot) => {
        currentDot.classList.remove('current-slide');
        targetDot.classList.add('current-slide');
    };

    const getNextSlide = () => {
        const currentSlide = track.querySelector('.current-slide');
        const nextSlide = currentSlide.nextElementSibling || slides[0];
        const currentDot = dotsNav.querySelector('.current-slide');
        const nextDot = currentDot.nextElementSibling || dots[0];
        
        moveToSlide(track, currentSlide, nextSlide);
        updateDots(currentDot, nextDot);
    };

    const getPrevSlide = () => {
        const currentSlide = track.querySelector('.current-slide');
        const prevSlide = currentSlide.previousElementSibling || slides[slides.length - 1];
        const currentDot = dotsNav.querySelector('.current-slide');
        const prevDot = currentDot.previousElementSibling || dots[dots.length - 1];

        moveToSlide(track, currentSlide, prevSlide);
        updateDots(currentDot, prevDot);
    };

    let autoPlayInterval = setInterval(getNextSlide, 10000);

    const resetInterval = () => {
        clearInterval(autoPlayInterval);
        autoPlayInterval = setInterval(getNextSlide, 10000);
    };

    nextButton.addEventListener('click', () => {
        getNextSlide();
        resetInterval();
    });

    prevButton.addEventListener('click', () => {
        getPrevSlide();
        resetInterval();
    });

    dotsNav.addEventListener('click', e => {
        const targetDot = e.target.closest('button');
        if (!targetDot) return;

        const currentSlide = track.querySelector('.current-slide');
        const currentDot = dotsNav.querySelector('.current-slide');
        const targetIndex = dots.findIndex(dot => dot === targetDot);
        const targetSlide = slides[targetIndex];

        moveToSlide(track, currentSlide, targetSlide);
        updateDots(currentDot, targetDot);
        resetInterval();
    });

    window.addEventListener('resize', () => {
        const newSlideWidth = slides[0].getBoundingClientRect().width;
        slides.forEach((slide, index) => {
            slide.style.left = newSlideWidth * index + 'px';
        });
        const currentSlide = track.querySelector('.current-slide');
        track.style.transform = 'translateX(-' + currentSlide.style.left + ')';
    });
}

/* =========================================
   5. APP LOGIC
========================================= */
const PRICE_PER_UNIT = 9.99;
let uploadedFiles = [];

const fileInput = document.getElementById('file-input');
const uploadTrigger = document.getElementById('upload-trigger');
const magnetGrid = document.getElementById('magnet-grid');
const emptyState = document.getElementById('empty-state');
const countDisplay = document.getElementById('count-display');
const priceDisplay = document.getElementById('price-display');
const btnCheckout = document.getElementById('btn-checkout');
const btnClearAll = document.getElementById('btn-clear-all');
const btnAddEmpty = document.getElementById('btn-add-empty');

if (uploadTrigger && fileInput) {
    uploadTrigger.addEventListener('click', () => fileInput.click());

    fileInput.addEventListener('change', (e) => {
        handleFiles(e.target.files);
        fileInput.value = '';
    });

    uploadTrigger.addEventListener('dragover', (e) => {
        e.preventDefault();
        uploadTrigger.style.borderColor = 'var(--accent)';
    });
    uploadTrigger.addEventListener('dragleave', () => {
        uploadTrigger.style.borderColor = 'var(--border)';
    });
    uploadTrigger.addEventListener('drop', (e) => {
        e.preventDefault();
        uploadTrigger.style.borderColor = 'var(--border)';
        if(e.dataTransfer.files.length) handleFiles(e.dataTransfer.files);
    });
}

if (btnAddEmpty) {
    btnAddEmpty.addEventListener('click', () => fileInput.click());
}

if (btnClearAll) {
    btnClearAll.addEventListener('click', () => {
        if(confirm('Remover todas as fotos?')) {
            uploadedFiles = [];
            renderGrid();
            updateSummary();
        }
    });
}

function handleFiles(files) {
    Array.from(files).forEach(file => {
        if(file.type.startsWith('image/')) {
            uploadedFiles.push(file);
        }
    });
    renderGrid();
    updateSummary();
}

function removeFile(index) {
    uploadedFiles.splice(index, 1);
    renderGrid();
    updateSummary();
}

function renderGrid() {
    magnetGrid.innerHTML = '';
    
    if(uploadedFiles.length === 0) {
        magnetGrid.appendChild(emptyState);
        return;
    }

    uploadedFiles.forEach((file, index) => {
        const url = URL.createObjectURL(file);
        const card = document.createElement('div');
        card.className = 'magnet-card';
        card.innerHTML = `
            <img src="${url}">
            <div class="btn-remove-photo" onclick="removeFile(${index})">
                <i class="ph-bold ph-x"></i>
            </div>
        `;
        magnetGrid.appendChild(card);
    });
}

function updateSummary() {
    const count = uploadedFiles.length;
    const total = count * PRICE_PER_UNIT;
    
    countDisplay.innerText = `${count} foto${count !== 1 ? 's' : ''}`;
    priceDisplay.innerText = total.toLocaleString('pt-BR', {style: 'currency', currency: 'BRL'});
    
    if(count > 0) {
        btnCheckout.disabled = false;
        btnCheckout.innerHTML = `Pagar ${priceDisplay.innerText}`;
        if(btnClearAll) btnClearAll.classList.remove('hidden');
    } else {
        btnCheckout.disabled = true;
        btnCheckout.innerText = 'Finalizar';
        if(btnClearAll) btnClearAll.classList.add('hidden');
    }
}

if(btnCheckout) {
    btnCheckout.addEventListener('click', () => {
        alert(`Indo para o checkout...\nValor Total: ${priceDisplay.innerText}`);
    });
}