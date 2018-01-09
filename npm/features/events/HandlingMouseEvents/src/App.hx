import motion.Actuate;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.display.Stage;
import openfl.events.MouseEvent;
import openfl.utils.AssetLibrary;
import openfl.utils.AssetManifest;
import openfl.utils.Assets;


class App extends Sprite {
	
	
	private var Logo:Sprite;
	private var Destination:Sprite;
	
	private var cacheOffsetX:Float;
	private var cacheOffsetY:Float;
	
	
	public function new () {
		
		super ();
		
		Logo = new Sprite ();
		Logo.addChild (new Bitmap (Assets.getBitmapData ("assets/openfl.png")));
		Logo.x = 100;
		Logo.y = 100;
		Logo.buttonMode = true;
		
		Destination = new Sprite ();
		Destination.graphics.beginFill (0xF5F5F5);
		Destination.graphics.lineStyle (1, 0xCCCCCC);
		Destination.graphics.drawRect (0, 0, Logo.width + 10, Logo.height + 10);
		Destination.x = 300;
		Destination.y = 95;
		
		addChild (Destination);
		addChild (Logo);
		
		Logo.addEventListener (MouseEvent.MOUSE_DOWN, Logo_onMouseDown);
		
	}
	
	
	
	
	// Event Handlers
	
	
	
	
	private function Logo_onMouseDown (event:MouseEvent):Void {
		
		cacheOffsetX = Logo.x - event.stageX;
		cacheOffsetY = Logo.y - event.stageY;
		
		stage.addEventListener (MouseEvent.MOUSE_MOVE, stage_onMouseMove);
		stage.addEventListener (MouseEvent.MOUSE_UP, stage_onMouseUp);
		
	}
	
	
	private function stage_onMouseMove (event:MouseEvent):Void {
		
		Logo.x = event.stageX + cacheOffsetX;
		Logo.y = event.stageY + cacheOffsetY;
		
	}
	
	
	private function stage_onMouseUp (event:MouseEvent):Void {
		
		if (Destination.hitTestPoint (event.stageX, event.stageY)) {
			
			Actuate.tween (Logo, 1, { x: Destination.x + 5, y: Destination.y + 5 } );
			
		}
		
		stage.removeEventListener (MouseEvent.MOUSE_MOVE, stage_onMouseMove);
		stage.removeEventListener (MouseEvent.MOUSE_UP, stage_onMouseUp);
		
	}
	
	
	
	
	// Entry Point
	
	
	
	
	static function main () {
		
		var manifest = new AssetManifest ();
		manifest.addBitmapData ("assets/openfl.png");
		
		AssetLibrary.loadFromManifest (manifest).onComplete (function (library) {
			
			Assets.registerLibrary ("default", library);
			
			var stage = new Stage (550, 400, 0xFFFFFF, App);
			js.Browser.document.body.appendChild (stage.element);
			
		}).onError (function (e) {
			
			trace (e);
			
		});
		
	}
	
	
}