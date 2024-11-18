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
}
