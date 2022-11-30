#include <string.h>

/**
 * Recursively find all files and directories
 * in `directory` that match the given criteria.
 *
 * Parameters:
 * `directory`: The starting directory to begin
 *              the search. This parameter will
 *              always be provided (i.e. never NULL).
 *
 * `name`:      If provided, any printed files or
 *              directories must have this name.
 *              Note that you should still search through
 *              directories that do not match `name`.
 *              If not provided (i.e. name == NULL),
 *              there are no restrictions on the name.
 *
 * `min_depth`: If provided, any printed files or
 *              directories must occur at least `min_depth`
 *              directories deep.
 *              Any files or directories existing in the
 *              provided `directory` are considered to be
 *              of depth 0.
 *              If not provided (i.e. min_depth == -1),
 *              there are no restrictions on minimum depth.
 *
 * `max_depth`: If provided, any printed files or
 *              directories must occur at most `max_depth`
 *              directories deep.
 *              Any files or directories existing in the
 *              provided `directory` are considered to be
 *              of depth 0.
 *              If not provided (i.e. max_depth == -1),
 *              there are no restrictions on maximum depth.
 */
void _22t2final_q7(char *directory, char *name, int min_depth, int max_depth) {
	// TODO
}
