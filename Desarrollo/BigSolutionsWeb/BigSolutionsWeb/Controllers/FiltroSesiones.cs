using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;

namespace BigSolutionsWeb.Controllers
{
    public class FiltroSesiones : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext context)
        {
            if (context.HttpContext.Session.GetString("TOKEN") == null)
            {
                context.Result = new RedirectToRouteResult(new RouteValueDictionary
                {
                    { "controller","Usuario" },
                    { "action","InicioSesion" }
                });
            }

            base.OnActionExecuting(context);
        }
    }
    public class FiltroAdmin : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext context)
        {
            if (Convert.ToInt64(context.HttpContext.Session.GetString("ROL")) != 1 && Convert.ToInt64(context.HttpContext.Session.GetString("ROL")) != 2)
            {
                context.Result = new RedirectToRouteResult(new RouteValueDictionary
                {
                    { "controller","Home" },
                    { "action","Index" }
                });
            }

            base.OnActionExecuting(context);
        }
    }
    public class AutorizacionFiltro : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext context)
        {
            var sessionId = context.HttpContext.Session.GetString("IDUSUARIO");
            if (string.IsNullOrEmpty(sessionId))
            {
                // Si no hay sesión activa, redirigir al inicio de sesión
                context.Result = new RedirectToActionResult("InicioSesion", "Usuario", null);
            }
            else
            {
                // Si el usuario está autenticado, asegurarse de que no se almacene en caché la página
                context.HttpContext.Response.Headers["Cache-Control"] = "no-cache, no-store, must-revalidate";
                context.HttpContext.Response.Headers["Pragma"] = "no-cache";
                context.HttpContext.Response.Headers["Expires"] = "0";
            }

            base.OnActionExecuting(context);
        }
    }
}
