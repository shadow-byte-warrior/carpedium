import { createClient } from "@supabase/supabase-js";

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL;
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseAnonKey) {
  console.error("Warning: Missing Supabase environment variables. Database integration will be unavailable.");
}

// Fallback to placeholders if missing to prevent top-level bundle execution crash
export const supabase = createClient(
  supabaseUrl || "https://placeholder-url-missing.supabase.co",
  supabaseAnonKey || "placeholder-anon-key-missing"
);

