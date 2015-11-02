	     function soundPlayer(source,width,height){
			var args=[];
			args.push("<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0\" width=\""+width+"\" height=\""+height+"\">");
			args.push("<param name=\"movie\" value=\"http://www.21cbr.com/special/audioPlayer.swf?soundFile="+source+"&bg=0x97B7C8&leftbg=0x8C0000&lefticon=0xF2F2F2&rightbg=0xE58903&rightbghover=0xF9BC00&righticon=0xF2F2F2&righticonhover=0xFFFFFF&text=0x333333&slider=0x8C0000&track=0x97B7C8&border=0x97B7C8&loader=0x3E5F7D&autostart=0&loop=no\" />");
			args.push("<param name=\"quality\" value=\"high\" />");
			args.push("<param value=\"transparent\" name=\"wmode\" />");

			args.push("<EMBED src=\"http://www.21cbr.com/special/audioPlayer.swf?soundFile="+source+"&bg=0x97B7C8&leftbg=0x8C0000&lefticon=0xF2F2F2&rightbg=0x3E5F7D&rightbghover=0xF9BC00&righticon=0xF2F2F2&righticonhover=0xFFFFFF&text=0x333333&slider=0x8C0000&track=0x97B7C8&border=0x97B7C8&loader=0x3E5F7D&autostart=0&loop=no\" width=\""+width+"\" height=\""+height+"\" wmode=\"transparent\" type=\"application/x-shockwave-flash\"></EMBED>");

			args.push("</object>");
			document.write(args.join(""));
		      
		 }