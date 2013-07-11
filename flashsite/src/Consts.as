﻿package
{
    import flash.display.*;
    import flash.system.*;

    public class Consts extends Object
    {
        public static const MIN_WIDTH:int = 980;
        public static const MIN_HEIGHT:int = 600;
        public static const MAX_WIDTH:int = 1920;
        public static const MAX_HEIGHT:int = 993;
        public static const ORIGINAL_WIDTH:int = 1680;
        public static const ORIGINAL_HEIGHT:int = 800;
        public static const MAIN_WEBSITE_URL:String = "http://www.7road.com";
        public static var CROSS_DOMAIN_FILE:String = "";
        public static var RESOURCE_ADDRESS_PREFIX:String = "";

        public function Consts()
        {
        }

        public static function limitWidth(_width:Number) : Number
        {
            var w:Number = _width;
            if (w < MIN_WIDTH)
            {
                w = MIN_WIDTH;
            }
            if (w > MAX_WIDTH)
            {
                w = MAX_WIDTH;
            }
            return w;
        }

        public static function limitHeight(_height:Number) : Number
        {
            var h:Number = _height;
            if (h < MIN_HEIGHT)
            {
                h = MIN_HEIGHT;
            }
            if (h > MAX_HEIGHT)
            {
                h = MAX_HEIGHT;
            }
            return h;
        }
		/**
		 *资源路径 
		 * @param url
		 * @return 
		 * 
		 */		
		public static function resURL(url:String) : String
		{
			if (!url || url.length <= 0)
			{
				return url;
			}
			if (!RESOURCE_ADDRESS_PREFIX || RESOURCE_ADDRESS_PREFIX.length <= 0)
			{
				return url;
			}
			return RESOURCE_ADDRESS_PREFIX + url;
		}
    }
}
