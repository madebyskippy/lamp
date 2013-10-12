package
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxTilemap;

	public class PlayState extends FlxState
	{
		public var level:FlxTilemap;
		public var player:FlxSprite;
		public var rows:int = 30;
		public var columns:int = 40;
		
		//private vars
		private var darkness:FlxSprite;
		
		private function pushPlatform(data:Array, platform:Array, columns:int):Array
		{
			if(columns + 2 * platform.length  < rows){
				for(var i:int = 0; i < platform.length; i++){
					data.push(platform[i]);
				};
				for(i = 0; i < platform.length; i++){
					data.push(0);
				};
			}else{
				for(var n:int = columns; n < rows; n++){
					data.push(0);
				}
			}
			return data;
		}
		
		override public function create():void
		{
			FlxG.bgColor = 0xffaaaaaa;
			var rows:int = 30;
			var columns:int = 40;
			var threshold:Number = 0.5;
			var platform3:Array = Array(1,1,1);
			var platform4:Array = Array(1,1,1,1);
			var platform5:Array = Array(1,1,1,1,1);
			var platform6:Array = Array(1,1,1,1,1,1);
			var platformData:Array = new Array(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1);
			//for every row
			for(var j:int = 0; j < rows -1; j++){
				for(var i:int = 0; i < columns; i++){
					platformData.push(1);
					//Get a number between 3 and 6 inclusive
					var platNum:int = Math.random() * 4 + 3;
					switch(platNum){
						case 3:
							platformData = pushPlatform(platformData, platform3, i);
							break;
						case 4:
							platformData = pushPlatform(platformData, platform4, i);
							break;
						case 5:
							platformData = pushPlatform(platformData, platform5, i);
							break;
						case 6:
							platformData = pushPlatform(platformData, platform6, i);
							break;
					}	
				}
			}
			
			
// ATTEMPT # 1
//			//for every row
//			for(var i:int = 0; i < rows - 1; i++){
//				//attach a 1 to make sure we have an end border
//				platformData.push(1);
//				//for each column excluding the last one
//				for(var j:int = 0; j < columns; j++){
//					//generate some random number
//					var num:Number = Math.random();
//					//if it's above some threshold
//					if(num > 0.5){
//						//place a tile there
//						platformData.push(1);
//						threshold += 0.35;
//						
//					}else platformData.push(0);
//				
//				}
//				//place a 1 for the rightmost edge
//				platformData.push(1);
//			}
			


			level = new FlxTilemap();
			level.loadMap(FlxTilemap.arrayToCSV(platformData,40), FlxTilemap.ImgAuto, 0, 0, FlxTilemap.AUTO);
			add(level);
			
			
			player = new Player(); 
			player.x = FlxG.width / 2; 
			player.y = FlxG.height - 31; 
			
			add(player);
			
			//add the darkness last bc we want it to be the top layer 
			darkness = new FlxSprite(0,0);
			darkness.makeGraphic(FlxG.width, FlxG.height, 0xff000000);
			darkness.scrollFactor.x = darkness.scrollFactor.y = 0;
			darkness.blend = "multiply";
			
			var light:Light = new Light(FlxG.width / 2, FlxG.height / 2, darkness);
			add(light);
//			add(darkness);
		}
		
		override public function update():void 
		{
			super.update();
			FlxG.collide(level, player);
		}
		
		override public function draw():void {
			darkness.fill(0xff000000);
			super.draw();
		}
	}
}