export const tokens = {
  background: "#FFFFFF",
  surfaceAlt: "#F8FAFC",
  primary: "#14B8A6",
  primaryLight: "#2DD4BF",
  primaryStrong: "#0F766E",
  accent: "#0EA5E9",
  ink: "#0F172A",
  inkDim: "#64748B",
  line: "#E2E8F0",
  teal: "#14B8A6",
  tealBright: "#2DD4BF",
  obsidian: "#0A1412",
  obsidian2: "#0F1B18",
  offWhite: "#EDECE3",
  offWhiteDim: "#A8B0AC",
} as const;

export type ThemeTokens = typeof tokens;
