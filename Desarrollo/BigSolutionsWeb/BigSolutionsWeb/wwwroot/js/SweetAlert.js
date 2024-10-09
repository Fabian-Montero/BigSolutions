// SweetAlert para eliminar el perfil de usuario
$(function () {
    $('.btn-EliminarPerfilUsuario').on('click', function (e) {
        e.preventDefault(); // Evita la acción por defecto del enlace
        var $this = $(this);
        var url = $this.attr('href'); // Obtiene la URL desde el href

        Swal.fire({
            title: '¿Está seguro de que desea eliminar su perfil?',
            text: "¡Esta acción no se puede deshacer!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#c1952c',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Sí, eliminar',
            cancelButtonText: 'Cancelar',
            customClass: {
                popup: 'my-swal-popup'
            }
        }).then((result) => {
            if (result.isConfirmed) {
                // Muestra el mensaje de éxito
                Swal.fire({
                    title: '¡Eliminado!',
                    text: 'Su perfil ha sido eliminado con éxito.',
                    icon: 'success',
                    confirmButtonColor: '#c1952c',
                    confirmButtonText: 'Aceptar'
                }).then(() => {
                    // Redirigir a la URL de eliminación después de cerrar el mensaje de éxito
                    window.location.href = url; // Redirigir a la URL de eliminación
                });
            }
        });
    });
});

// SweetAlert de confirmación de perfil de usuario actualizado
document.addEventListener('DOMContentLoaded', function () {
    $('#perfilForm').on('submit', function (event) {
        event.preventDefault();

        $.ajax({
            url: $(this).attr('action'),
            type: 'POST',
            data: $(this).serialize(),
            success: function (response) {
                Swal.fire({
                    icon: 'success',
                    title: 'Perfil actualizado',
                    text: 'Tu perfil ha sido actualizado con éxito.',
                    confirmButtonColor: '#c1952c',
                    showConfirmButton: false,
                    timer: 1500, // Tiempo en milisegundos que se mostrará la alerta (1.5 segundos)
                    customClass: {
                        popup: 'my-swal-popup'
                    }
                }).then(() => {
                    window.location.href = '/Home/Index';
                });
            }
        });
    });
});
function submitForm() {
    $('#perfilForm').submit();
}
