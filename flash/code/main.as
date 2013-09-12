package code {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.greensock.TweenMax;
	import com.greensock.easing.Cubic;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import com.adobe.images.JPGEncoder;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;

	import com.adobe.serialization.json.JSON;

	
	public class main extends MovieClip {
		
		//private var 
		private var degrees:Number;
		private var radians:int = degrees * Math.PI / 180;
		private var angleUtil:Number = (Math.PI * 2) / 12;
		
		private var _urlreq:URLRequest;
		private var _urlvar:URLVariables;
		private var _urlloa:URLLoader;
		private var _num:int;
		
		public function main() {
			// constructor code
			if (stage) {
				init();
			}else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function init(e:Event=null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			mcResult.visible = false;
			mcResult.alpha = 0;
			
			btnStart.addEventListener(MouseEvent.CLICK, onClickHandler);
			degrees = 0;
			//angleUtil = (Math.PI * 2) / 10;
			//trace(angleUtil);
			
			mcResult.btnClose.addEventListener(MouseEvent.CLICK, onHideHandler);
			mcResult.btnConfirm.addEventListener(MouseEvent.CLICK, onHideHandler);
		}
		
		private function onHideHandler(e:MouseEvent):void 
		{
				TweenMax.to(mcResult, .5, { autoAlpha:0 } );
		}
		
		
		private function onClickHandler(e:MouseEvent):void 
		{
			
			_urlvar = new URLVariables();
			_urlreq = new URLRequest();
			_urlloa = new URLLoader();
			
			var strBackendUrl:String =  "./function_all/index.php";
			
			
			trace(strBackendUrl);
			_urlvar.fun = "getaward";
			
			_urlloa.addEventListener(Event.COMPLETE, onCompInfoHandler);
			
			_urlloa.addEventListener(IOErrorEvent.IO_ERROR, onErrorHandler);
			
			_urlreq.data = _urlvar;
			_urlreq.url = strBackendUrl;
			_urlreq.method = "POST";
			_urlloa.load(_urlreq);
			
			
		}
		
		private function onErrorHandler(e:IOErrorEvent):void 
		{
			
			_num = 11;
			
			degrees =  _num * angleUtil;
			
			var mydegrees:int = degrees * 180 / Math.PI;
			
			
			TweenMax.to(b1, 12, { rotation:3600 + mydegrees, ease:Cubic.easeInOut, onComplete:function() {
				mcResult.mcWin.gotoAndStop(1);
					TweenMax.to(mcResult, .5, { autoAlpha:1 } );
					
				}} );
				
			TweenMax.to(mcDot.sc, 12, { rotation:3600 + mydegrees, ease:Cubic.easeInOut, onComplete:function() {
				
				
				}} );
		}
		
		private function onCompInfoHandler(e:Event):void 
		{
			var myData:Object = JSON.decode(e.target.data);
			
				//State	1	Ipad  mini
				//State	2	iPod nano 7（16G）
				//State	3	电子称
				//State	4	浴巾
				//State	5	装饰真皮卡片夹+外套绒
				//State	6	古铜镜
				//State	7	七件套
				//State	8	竹纤维毛巾
				//State	9	箭牌吉祥物
				//State	10	高级毛巾礼盒套装
				//State	0	没有中奖
				//State	-1	没有完成第一步
				//State	-2	没有完成第二步
				//State	-3	同一个微博ID只能玩一次
				//State	-4	系统错误

				switch (myData.state) {
					case "1":
						_num = 3;
						break;
					case "2":
						
						_num = 11;
						
						break;
					
				}
				
				
			
			
			
			
		}
	}
	
}
