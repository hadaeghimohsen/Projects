;(function () {
    var modalEl = document.getElementById('confirmModal')
    if (!modalEl) return

    var titleEl = document.getElementById('confirmTitle')
    var msgEl = document.getElementById('confirmMessage')
    var iconEl = document.getElementById('confirmIcon')
    var okBtn = document.getElementById('confirmOk')
    var cancelBtn = document.getElementById('confirmCancel')

    var bsModal = null
    if (typeof bootstrap !== 'undefined') {
        bsModal = new bootstrap.Modal(modalEl, { backdrop: 'static', keyboard: true })
    }

    var iconMap = {
        question: 'bx bx-help-circle',
        danger:   'bx bx-error-circle',
        success:  'bx bx-check-circle',
        warning:  'bx bx-alert-circle'
    }

    function showConfirm(opts) {
        if (!bsModal) return Promise.resolve(false)
        titleEl.textContent = opts.title || 'تایید عملیات'
        msgEl.textContent = opts.message || 'آیا مطمئن هستید؟'
        var type = opts.type || 'question'
        iconEl.className = 'confirm-modal-icon ' + (type === 'question' ? '' : 'is-' + type)
        iconEl.innerHTML = '<i class="' + (iconMap[type] || iconMap.question) + '"></i>'
        okBtn.textContent = opts.okText || 'بله'
        cancelBtn.textContent = opts.cancelText || 'خیر'
        if (opts.okClass) {
            okBtn.className = 'btn ' + opts.okClass
        } else {
            okBtn.className = 'btn btn-primary'
        }

        return new Promise(function (resolve) {
            var onOk = function () { okBtn.removeEventListener('click', onOk); bsModal.hide(); resolve(true) }
            var onCancel = function () { cancelBtn.removeEventListener('click', onCancel); bsModal.hide(); resolve(false) }
            var onHidden = function () {
                modalEl.removeEventListener('hidden.bs.modal', onHidden)
            }
            okBtn.addEventListener('click', onOk)
            cancelBtn.addEventListener('click', onCancel)
            modalEl.addEventListener('hidden.bs.modal', onHidden)
            bsModal.show()
        })
    }

    window.showConfirm = showConfirm
})()
