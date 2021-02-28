using Business;
using Common;
using Entities.DataModels;
using Entities.SessionModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using static Common.Constants;

namespace WorldCupBet.CustomActionFilters
{
    public class CheckUserSession : ActionFilterAttribute, IActionFilter
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            var currentUser = Utilities.GetCache<CurrentUser>(CacheKeys.CurrentUser);

            if (currentUser == null)
            {
                var routevalues = new RouteValueDictionary()
                    {
                        { "Controller", "Home" },
                        { "Action", "Login" }
                    };
                filterContext.Result = new RedirectToRouteResult(routevalues);
            }

            base.OnActionExecuting(filterContext);
        }
    }

    public class CheckIsFirstLogin : ActionFilterAttribute, IActionFilter
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            var actionName = filterContext.ActionDescriptor.ActionName;
            if (!actionName.Equals("ChangePassword") && !actionName.Equals("Logoff"))
            {
                var currentUser = Utilities.GetCache<CurrentUser>(CacheKeys.CurrentUser);

                if (currentUser != null && currentUser.IsFirstLogin == true)
                {
                    filterContext.Controller.TempData["IsFirstLogin"] = true;
                    var routevalues = new RouteValueDictionary()
                    {
                        { "Controller", "User" },
                        { "Action", "ChangePassword" }
                    };
                    filterContext.Result = new RedirectToRouteResult(routevalues);
                }
            }

            base.OnActionExecuting(filterContext);
        }
    }

    public class AdminOnly : ActionFilterAttribute, IActionFilter
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            var currentUser = Utilities.GetCache<CurrentUser>(CacheKeys.CurrentUser);

            if (currentUser == null)
            {
                var routevalues = new RouteValueDictionary()
                    {
                        { "Controller", "Home" },
                        { "Action", "Login" }
                    };
                filterContext.Result = new RedirectToRouteResult(routevalues);
            }
            else
            {
                if (currentUser.UserRole != (int)Enums.UserRoles.Admin)
                {
                    var routevalues = new RouteValueDictionary()
                    {
                        { "Controller", "Home" },
                        { "Action", "AccessDenied" }
                    };
                    filterContext.Result = new RedirectToRouteResult(routevalues);
                }
            }

            base.OnActionExecuting(filterContext);
        }
    }
}