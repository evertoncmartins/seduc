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
   2. DARK MODE
========================================= */
const themeBtns = document.querySelectorAll('.theme-toggle');
const html = document.documentElement;

function updateThemeIcons(theme) {
    themeBtns.forEach(btn => {
        const icon = btn.querySelector('i');
        if (theme === 'dark') {
            icon.classList.replace('ph-moon', 'ph-sun');
        } else {
            icon.classList.replace('ph-sun', 'ph-moon');
        }
    });
}

function setTheme(theme) {
    if (theme === 'dark') {
        html.setAttribute('data-theme', 'dark');
        localStorage.setItem('theme', 'dark');
    } else {
        html.removeAttribute('data-theme');
        localStorage.setItem('theme', 'light');
    }
    updateThemeIcons(theme);
}

const savedTheme = localStorage.getItem('theme');
const systemDark = window.matchMedia('(prefers-color-scheme: dark)').matches;

if (savedTheme === 'dark' || (!savedTheme && systemDark)) {
    setTheme('dark');
}

themeBtns.forEach(btn => {
    btn.addEventListener('click', () => {
        const isDark = html.getAttribute('data-theme') === 'dark';
        setTheme(isDark ? 'light' : 'dark');
    });
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
   4. APP LOGIC
========================================= */
const PRICE_PER_UNIT = 2.50;
let uploadedFiles = [];

const fileInput = document.getElementById('file-input');
const uploadTrigger = document.getElementById('upload-trigger');
const magnetGrid = document.getElementById('magnet-grid');
const emptyState = document.getElementById('empty-state');
const countDisplay = document.getElementById('count-display');
const priceDisplay = document.getElementById('price-display');
const btnCheckout = document.getElementById('btn-checkout');
const btnClearAll = document.getElementById('btn-clear-all');

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