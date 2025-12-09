/* =========================================
   LÓGICA DE NAVEGAÇÃO (SPA)
========================================= */
const landingView = document.getElementById('landing-view');
const studioView = document.getElementById('studio-view');

function openStudio() {
    // Esconde Landing, Mostra Studio
    landingView.classList.add('hidden');
    studioView.classList.remove('hidden');
    studioView.classList.add('fade-in');
    window.scrollTo(0,0); // Reseta o scroll
}

function closeStudio() {
    // Esconde Studio, Mostra Landing
    studioView.classList.add('hidden');
    landingView.classList.remove('hidden');
    landingView.classList.add('fade-in');
}

/* =========================================
   LÓGICA DO ESTÚDIO (APP)
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

// Eventos de Upload
uploadTrigger.addEventListener('click', () => fileInput.click());

fileInput.addEventListener('change', (e) => {
    handleFiles(e.target.files);
    fileInput.value = ''; 
});

// Drag & Drop
uploadTrigger.addEventListener('dragover', (e) => {
    e.preventDefault();
    uploadTrigger.style.background = '#EFF6FF';
    uploadTrigger.style.borderColor = '#3B82F6';
});
uploadTrigger.addEventListener('dragleave', () => {
    uploadTrigger.style.background = '#F9FAFB';
    uploadTrigger.style.borderColor = '#E5E7EB';
});
uploadTrigger.addEventListener('drop', (e) => {
    e.preventDefault();
    uploadTrigger.style.background = '#F9FAFB';
    uploadTrigger.style.borderColor = '#E5E7EB';
    if(e.dataTransfer.files.length) handleFiles(e.dataTransfer.files);
});

// Funções Principais
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
    
    countDisplay.innerText = count;
    priceDisplay.innerText = total.toLocaleString('pt-BR', {style: 'currency', currency: 'BRL'});
    
    if(count > 0) {
        btnCheckout.disabled = false;
        btnCheckout.innerText = `Finalizar Pedido (${count})`;
    } else {
        btnCheckout.disabled = true;
        btnCheckout.innerText = 'Finalizar Pedido';
    }
}

// Botão Finalizar (Simulação)
btnCheckout.addEventListener('click', () => {
    alert(`Redirecionando para pagamento...\nTotal: ${priceDisplay.innerText}`);
});