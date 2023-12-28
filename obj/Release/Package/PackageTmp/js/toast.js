document.addEventListener('DOMContentLoaded', function () {
    let notifications = document.querySelector('.notifications');

    document.querySelectorAll('.success').forEach(function (success) {
        success.onclick = function () {
            let type = 'success';
            let icon = 'fa-solid fa-circle-check';
            let title = 'Giỏ hàng';
            let text = 'Thêm vào giỏ hàng thành công';
            createToast(type, icon, title, text);
        }
    });

    document.querySelectorAll('.error').forEach(function (error) {
        error.onclick = function () {
            let type = 'error';
            let icon = 'fa-solid fa-circle-exclamation';
            let title = 'Yêu thích';
            let text = 'Thêm vào yêu thích thành công';
            createToast(type, icon, title, text);
        }
    });

    function createToast(type, icon, title, text) {
        let newToast = document.createElement('div');
        newToast.innerHTML = `
            <div class="toast ${type}">
                <i class="${icon}"></i>
                <div class="content">
                    <div class="title">${title}</div>
                    <span>${text}</span>
                </div>
                <i class="fa-solid fa-xmark" onclick="(this.parentElement).remove()"></i>
            </div>`;
        notifications.appendChild(newToast);
        newToast.timeOut = setTimeout(
            () => newToast.remove(), 3000
        )
    }
});
