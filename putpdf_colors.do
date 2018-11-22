local namelist aliceblue ghostwhite            navajowhite  ///
         antiquewhite    gold                  navy    ///
         aqua            goldenrod             oldlace   ///
         aquamarine      gray                  olive   ///
         azure           green                 olivedrab   ///
         beige           greenyellow           orange   ///
         bisque          honeydew              orangered   ///
         black           hotpink               orchid   ///
         blanchedalmond  indianred             palegoldenrod   ///
         blue            indigo                palegreen   ///
         blueviolet      ivory                 paleturquoise   ///
         brown           khaki                 palevioletred   ///
         burlywood       lavender              papayawhip   ///
         cadetblue       lavenderblush         peachpuff   ///
         chartreuse      lawngreen             peru   ///
         chocolate       lemonchiffon          pink   ///
         coral           lightblue             plum   ///
         cornflowerblue  lightcoral            powderblue   ///
         cornsilk        lightcyan             purple   ///
         crimson         lightgoldenrodyellow  red   ///
         cyan            lightgray             rosybrown   ///
         darkblue        lightgreen            royalblue   ///
         darkcyan        lightpink             saddlebrown   ///
         darkgoldenrod   lightsalmon           salmon   ///
         darkgray        lightseagreen         sandybrown   ///
         darkgreen       lightskyblue          seagreen   ///
         darkkhaki       lightslategray        seashell   ///
         darkmagenta     lightsteelblue        sienna   ///
         darkolivegreen  lightyellow           silver   ///
         darkorange      lime                  skyblue   ///
         darkorchid      limegreen             slateblue   ///
         darkred         linen                 slategray   ///
         darksalmon      magenta               snow   ///
         darkseagreen    maroon                springgreen   ///
         darkslateblue   mediumaquamarine      steelblue   ///
         darkslategray   mediumblue            tan   ///
         darkturquoise   mediumorchid          teal   ///
         darkviolet      mediumpurple          thistle   ///
         deeppink        mediumseagreen        tomato   ///
         deepskyblue     mediumslateblue       turquoise   ///
         dimgray         mediumspringgreen     violet   ///
         dodgerblue      mediumturquoise       wheat   ///
         firebrick       mediumvioletred       white   ///
         floralwhite     midnightblue          whitesmoke   ///
         forestgreen     mintcream             yellow   ///
         fuchsia         mistyrose             yellowgreen   ///
         gainsboro       moccasin

putpdf clear
putpdf begin
putpdf paragraph				 
				 
tokenize "`namelist'"
while "`1'" != "" {
	putpdf text ("`1'"), font("", 14, `1') linebreak
	macro shift
}

putpdf save putpdf_colors, replace
