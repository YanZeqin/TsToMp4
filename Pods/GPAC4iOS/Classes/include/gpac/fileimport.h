#ifndef GPAC4iOS_fileimport_h
#define GPAC4iOS_fileimport_h

#import <gpac/media_tools.h>

GF_Err import_file(GF_ISOFile *dest, char *inName, u32 import_flags, Double force_fps, u32 frames_per_sample);

#endif
