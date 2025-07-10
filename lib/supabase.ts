import { createClient } from "@supabase/supabase-js"

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL!
const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!

export const supabase = createClient(supabaseUrl, supabaseAnonKey)

// Types for our database tables
export interface Client {
  id: string
  name: string
  logo_url?: string
  offices: number
  visible: boolean
  created_at: string
  updated_at: string
  client_admins?: ClientAdmin[]
  orders_count?: number
  products_count?: number
  last_order_date?: string
}

export interface ClientAdmin {
  id: string
  client_id: string
  name: string
  email?: string
  phone?: string
  created_at: string
}

export interface Product {
  id: string
  sku: string
  name: string
  description?: string
  category?: string
  subcategory?: string
  type?: string
  specifications?: any
  unit_price?: number
  unit_type?: string
  units_per_case?: number
  case_price?: number
  image_url?: string
  status: string
  created_at: string
  updated_at: string
  orders_count?: number
  assigned_clients_count?: number
}

export interface Order {
  id: string
  order_number: string
  client_id: string
  ordered_by: string
  ordered_by_email?: string
  status: string
  total_amount?: number
  notes?: string
  created_at: string
  updated_at: string
  client?: Client
  order_items?: OrderItem[]
}

export interface OrderItem {
  id: string
  order_id: string
  product_id: string
  quantity: number
  unit_price: number
  total_price: number
  created_at: string
  product?: Product
}

export interface ClientProduct {
  id: string
  client_id: string
  product_id: string
  assigned_at: string
  client?: Client
  product?: Product
}
