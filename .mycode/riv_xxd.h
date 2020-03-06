/*
 * Copyright(c) 2016-2100.   JLLim.  All rights reserved.
 */
/*
 * FileName:      riv_xxd.h
 * Author:        Jielong Lin 
 * Email:         jielong.lin@qq.com
 * DateTime:      2020-03-06 10:51:05
 * ModifiedTime:  2020-03-06 10:53:40
 */

#ifndef __RIV_XXD_H__
#define __RIV_XXD_H__

#ifdef __cplusplus
extern "C" {
#endif

/**
 * riv_xxd - dump hex raw data and character data with the specified format
 *
 * dump hex raw data in the left and character data in the right
 *
 * retval: none
 *
 * For VIM, it is similar to the follows:
 *   :%!xxd -g 1
 */
void riv_xxd(void *data, int len);


#ifdef __cplusplus
}
#endif

#endif /* ENDOF __RIV_XXD_H__ */

