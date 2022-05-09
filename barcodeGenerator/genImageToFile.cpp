//
//  genImageToFile.cpp
//  barcodeGenerator
//
//  Created by Blotenko on 09.05.2022.
//

#include "genImageToFile.hpp"
#include <iostream>
#include <string>
#include "zintlib/zint.h"




int typeToZint(unsigned type)
{
    switch (type) {
        case 0  : return 20;
        case 1  : return 8;
        case 2  : return 58;
        case 3  : return 60;
        case 4  : return 1;
        default : break;
    }

    return 0;
}


void createBarcodeImageByZint(std::string path, std::string value, int type){
    
    const char* tempPath = path.c_str();
    
    auto zint = ZBarcode_Create(tempPath,typeToZint(type));
    
    strcpy(zint->fgcolour, "000000");
    zint->output_options  = BOLD_TEXT;
    zint->border_width    =  3;
    zint->scale           = 10.0;
    zint->symbology       = typeToZint(type);
    zint->show_hrt        = 0;
    
    int error = ZBarcode_Encode_and_Print(zint, reinterpret_cast<const uint8_t*>(value.c_str()), 0,0);
    std::cout<<error<<std::endl;
    ZBarcode_Delete(zint);
    
    return ;
}
