using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace Common
{
    public class Utilities
    {
        public static void SaveCache<T>(string key, T value)
        {
            HttpContext.Current.Session[key] = value;
        }

        public static T GetCache<T>(string key)
        {
            var value = (T)HttpContext.Current.Session[key];
            if (value == null)
            {
                return default(T);
            }
            return value;
        }

        public static void RemoveCache(string key)
        {
            HttpContext.Current.Session.Remove(key);
        }
    }
}
