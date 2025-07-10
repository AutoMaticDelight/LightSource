import { supabase } from "../supabase"
import type { Client } from "../supabase"

export async function getClients(): Promise<Client[]> {
  const { data, error } = await supabase
    .from("clients")
    .select(`
      *,
      client_admins (*),
      orders (id, created_at),
      client_products (id)
    `)
    .order("name")

  if (error) {
    console.error("Error fetching clients:", error)
    throw error
  }

  // Transform the data to include counts and last order date
  return data.map((client) => ({
    ...client,
    orders_count: client.orders?.length || 0,
    products_count: client.client_products?.length || 0,
    last_order_date:
      client.orders?.length > 0
        ? new Date(Math.max(...client.orders.map((o: any) => new Date(o.created_at).getTime()))).toLocaleDateString(
            "en-US",
            { month: "short", day: "numeric", year: "2-digit" },
          )
        : null,
  }))
}

export async function createClient(clientData: Partial<Client>) {
  const { data, error } = await supabase.from("clients").insert([clientData]).select().single()

  if (error) {
    console.error("Error creating client:", error)
    throw error
  }

  return data
}

export async function updateClient(id: string, updates: Partial<Client>) {
  const { data, error } = await supabase.from("clients").update(updates).eq("id", id).select().single()

  if (error) {
    console.error("Error updating client:", error)
    throw error
  }

  return data
}

export async function deleteClient(id: string) {
  const { error } = await supabase.from("clients").delete().eq("id", id)

  if (error) {
    console.error("Error deleting client:", error)
    throw error
  }
}
