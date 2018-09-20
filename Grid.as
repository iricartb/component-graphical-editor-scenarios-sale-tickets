package {
	
	import flash.display.*
	import flash.events.*;
	
	public class Grid extends Sprite {
		
		public function Grid(showOnlyBorders:Boolean) {
			if (showOnlyBorders) {
				graphics.lineStyle(0.2, 0x330000, 0.1);
				
         	graphics.moveTo(-2490, -2490);				
			  	graphics.lineTo(-2490, 2490);
			  	graphics.moveTo(-2490, -2490);				
			  	graphics.lineTo(2490, -2490);
           	
				graphics.moveTo(0, -2490);				
			  	graphics.lineTo(0, 2490);
			  	graphics.moveTo(-2490, 0);				
			  	graphics.lineTo(2490, 0);
				
           	graphics.moveTo(2490, -2490);				
			  	graphics.lineTo(2490, 2490);
			  	graphics.moveTo(-2490, 2490);				
			  	graphics.lineTo(2490, 2490);
			}
			else {
				for (var i:int=1; i<168; i++){
					if ((i == 1) || (i == 84) || (i == 167)) graphics.lineStyle(0.2,0x330000,0.3);
			  		else graphics.lineStyle(0.2,0x330000,0.1);
			  
           		graphics.moveTo(-2520+(30*i),-2490);				
			  		graphics.lineTo(-2520+(30*i),4980-2490);
			  		graphics.moveTo(-2490,-2520+(30*i));				
			  		graphics.lineTo(4980-2490,-2520+(30*i));
				}
			}
		}		
	}
}