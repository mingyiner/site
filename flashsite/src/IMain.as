package
{
	/**
	 *每个Swf都实现这个接口 
	 * @author dangweiwei
	 * 
	 */
    public interface IMain
    {

        public function IMain();

        function initializeWithData(param1 = null) : void;

        function close() : void;

    }
}
