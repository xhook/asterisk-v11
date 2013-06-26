/*! \file
 * \brief 8-bit data
 *
 * Copyright (C) 2008, Digium, Inc.
 *
 * Distributed under the terms of the GNU General Public License
 *
 */

/* Opus, a 20ms sample */
static uint8_t ex_opus[] = {
	0x4b, 0x41, 0x25, 0x0b, 0xe4, 0x55, 0xc6, 0x74,
	0xda, 0xbb, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
};

static struct ast_frame *opus_sample(void)
{
	static struct ast_frame f = {
		.frametype = AST_FRAME_VOICE,
		.datalen = sizeof(ex_opus),
		.samples = 960,	//ARRAY_LEN(ex_opus),
		.mallocd = 0,
		.offset = 0,
		.src = __PRETTY_FUNCTION__,
		.data.ptr = ex_opus,
	};

	ast_format_set(&f.subclass.format, AST_FORMAT_OPUS, 0);

	return &f;
}
