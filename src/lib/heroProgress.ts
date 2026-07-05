/**
 * Shared mutable scroll-progress value for the hero shield assembly.
 * Read every frame inside useFrame — a plain ref object avoids pushing
 * 60fps updates through React state/context.
 */
export const heroProgress = { value: 0 };
