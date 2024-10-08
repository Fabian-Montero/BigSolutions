// ---> Mensaje para cerrar sesión o cierre de sesión fallida
$(function () {
    $('.btn-cerrarSesion').on('click', function (e) {
        e.preventDefault();
        var $this = $(this);
        var url = $this.data('url');

        Swal.fire({
            title: '¿Estás seguro de que deseas cerrar sesión?',
            text: "Si confirmas, serás redirigido a la página de inicio de sesión.",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#c1952c',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Sí, cerrar sesión',
            cancelButtonText: 'Cancelar',
            customClass: {
                popup: 'my-swal-popup'
            }
        }).then((result) => {
            if (result.isConfirmed) {
                // Realiza la solicitud de cierre de sesión con ajax
                $.ajax({
                    url: url,
                    type: 'GET',
                    success: function () {
                        // Redirige si el cierre de sesión es exitoso
                        window.location.href = url;
                    },
                    error: function () {
                        // Muestra un mensaje de error si algo falla y no redirige
                        Swal.fire({
                            title: 'Cierre de sesión fallida',
                            text: 'No se pudo cerrar la sesión. Por favor, inténtalo nuevamente.',
                            icon: 'error',
                            confirmButtonColor: '#d33',
                            confirmButtonText: 'Aceptar'
                        });
                    }
                });
            }
        });
    });
});


// ---> Mensaje de cierre de sesión por inactividad
//let timeout;

//// Función para restablecer el temporizador
//function resetTimer() {
//    clearTimeout(timeout);
//    timeout = setTimeout(() => {
//        showExpirationAlert();
//    }, 1 * 60 * 1000); // 10 minutos
//}
//// Función para mostrar la alerta de expiración
//function showExpirationAlert() {
//    Swal.fire({
//        title: 'Sesión Expirada',
//        text: 'Tu sesión ha expirado. Serás redirigido a la página de inicio de sesión.',
//        icon: 'warning',
//        confirmButtonColor: '#c1952c',
//        confirmButtonText: 'Aceptar',
//        customClass: {
//            popup: 'my-swal-popup'
//        }
//    }).then(() => {
//        window.location.href = '/Usuario/Salir';
//    });
//}
//// Event listeners para restablecer el temporizador
//window.onload = resetTimer;
//document.onmousemove = resetTimer;
//document.onkeypress = resetTimer;