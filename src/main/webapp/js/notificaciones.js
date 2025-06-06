function toggleNotifications() {
    var notificationDrawer = document.getElementById('notificationDrawer');

    if (notificationDrawer.style.right === '0px') {
        // Ocultar con animación
        notificationDrawer.style.right = '-390px';

        // Luego de que termine la animación, lo ocultas del todo
        setTimeout(function () {
            notificationDrawer.style.display = 'none';
        }, 300); // 300ms igual al tiempo de tu transición CSS
    } else {
        // Mostrar y deslizar
        notificationDrawer.style.display = 'block';
        setTimeout(function () {
            notificationDrawer.style.right = '0';
        }, 10); // Pequeño delay para aplicar la animación suavemente
    }
}
