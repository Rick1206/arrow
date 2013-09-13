package code
{
	
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
	
	public class main extends MovieClip
	{
		
		//private var 
		private var degrees:Number;
		private var radians:int = degrees * Math.PI / 180;
		private var angleUtil:Number = (Math.PI * 2) / 12;
		
		private var _urlreq:URLRequest;
		private var _urlvar:URLVariables;
		private var _urlloa:URLLoader;
		private var _num:int;
		
		public function main()
		{
			// constructor code
			if (stage)
			{
				init();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function init(e:Event = null):void
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
			TweenMax.to(mcResult, .5, {autoAlpha: 0});
		}
		
		private function onClickHandler(e:MouseEvent):void
		{
			
			_urlvar = new URLVariables();
			_urlreq = new URLRequest();
			_urlloa = new URLLoader();
			var ran:Number = Math.random() * 10000;
			var strBackendUrl:String = "http://arrowsanitary.showone.com.cn/interface.aspx" + "?randid=" + ran;
			
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
		
		}
		
		private function onCompInfoHandler(e:Event):void
		{
			trace(e.target.data);
			var strRes:String = e.target.data;
			//var myData:Object = JSON.decode(e.target.data);
			
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
			
			switch (strRes)
			{
				case "1": 
					mcResult.mcWin.visible = true;
					mcResult.mcLose.visible = false;
					mcResult.mcWin.gotoAndStop(5);
					_num = 3;
					break;
				case "2": 
					mcResult.mcWin.visible = true;
					mcResult.mcLose.visible = false;
					mcResult.mcWin.gotoAndStop(1);
					_num = 11;
					break;
				case "3": 
					mcResult.mcWin.visible = true;
					mcResult.mcLose.visible = false;
					mcResult.mcWin.gotoAndStop(8);
					_num = 6;
					break;
				case "4": 
					mcResult.mcWin.visible = true;
					mcResult.mcLose.visible = false;
					mcResult.mcWin.gotoAndStop(11);
					_num = 10;
					break;
				case "5": 
					mcResult.mcWin.visible = true;
					mcResult.mcLose.visible = false;
					mcResult.mcWin.gotoAndStop(9);
					_num = 7;
					break;
				case "6": 
					mcResult.mcWin.visible = true;
					mcResult.mcLose.visible = false;
					mcResult.mcWin.gotoAndStop(7);
					_num = 5;
					break;
				case "7": 
					mcResult.mcWin.visible = true;
					mcResult.mcLose.visible = false;
					mcResult.mcWin.gotoAndStop(3);
					_num = 12;
					break;
				case "8": 
					mcResult.mcWin.visible = true;
					mcResult.mcLose.visible = false;
					mcResult.mcWin.gotoAndStop(6);
					_num = 4;
					break;
				case "9": 
					mcResult.mcWin.visible = true;
					mcResult.mcLose.visible = false;
					mcResult.mcWin.gotoAndStop(10);
					_num = 9;
					break;
				case "10": 
					mcResult.mcWin.visible = true;
					mcResult.mcLose.visible = false;
					mcResult.mcWin.gotoAndStop(2);
					_num = 1;
					break;
				case "0": 
					mcResult.mcWin.visible = true;
					mcResult.mcLose.visible = false;
					mcResult.mcWin.gotoAndStop(4);
					_num = 2;
					break;
				case "-3":
					mcResult.mcWin.visible = false;
					mcResult.mcLose.visible = true;
					mcResult.mcLose.gotoAndStop(3);
					TweenMax.to(mcResult, .5, {autoAlpha: 1});
					return;
					break;
				case "-4":
					return;
					break;
				case "-2":
					mcResult.mcWin.visible = false;
					mcResult.mcLose.visible = true;
					mcResult.mcLose.gotoAndStop(4);
					TweenMax.to(mcResult, .5, {autoAlpha: 1});
					return;
					break;
				case "-1":
					mcResult.mcWin.visible = false;
					mcResult.mcLose.visible = true;
					mcResult.mcLose.gotoAndStop(2);
					TweenMax.to(mcResult, .5, {autoAlpha: 1});
					return;
					break;
			}
			
			degrees = _num * angleUtil;
			
			var mydegrees:int = degrees * 180 / Math.PI;
			
			TweenMax.to(b1, 12, {rotation: 3600 + mydegrees, ease: Cubic.easeInOut, onComplete: function()
				{
					TweenMax.to(mcResult, .5, {autoAlpha: 1});
				}});
			TweenMax.to(mcDot.sc, 12, {rotation: 3600 + mydegrees, ease: Cubic.easeInOut, onComplete: function()
				{
				
				}});
		
		}
	}

}
