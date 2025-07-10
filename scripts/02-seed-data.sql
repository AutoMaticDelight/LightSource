-- Insert sample clients
INSERT INTO clients (name, logo_url, offices, visible) VALUES
('Paramount Group Inc', '/placeholder.svg?height=60&width=120&text=Paramount+Group', 3, true),
('7th Floor- One Market Plaza', '/placeholder.svg?height=60&width=120&text=Paramount+Group', 0, true),
('8th Floor- One Market Plaza', '/placeholder.svg?height=60&width=120&text=Paramount+Group', 0, false),
('8th Floor- 50 Beale St', '/placeholder.svg?height=60&width=120&text=Building', 1, true),
('PixelNet', '/placeholder.svg?height=60&width=120&text=PixelNet', 1, true),
('Amazon Services', '/placeholder.svg?height=60&width=120&text=Amazon', 8, true),
('ACME Corporation', '/placeholder.svg?height=60&width=120&text=ACME', 2, true);

-- Insert client admins
INSERT INTO client_admins (client_id, name, email, phone) 
SELECT 
    c.id,
    CASE 
        WHEN c.name = 'Paramount Group Inc' THEN 'Steve Jackson'
        WHEN c.name = '8th Floor- 50 Beale St' THEN 'Steve Jackson'
        WHEN c.name = 'PixelNet' THEN 'Suzy'
        WHEN c.name = 'Amazon Services' THEN 'Admin Desk'
        WHEN c.name = 'ACME Corporation' THEN 'Steve Jackson'
        ELSE 'no admin'
    END,
    CASE 
        WHEN c.name = 'Paramount Group Inc' THEN 'steve@paramountgroup.com'
        WHEN c.name = '8th Floor- 50 Beale St' THEN 'steve@paramountgroup.com'
        WHEN c.name = 'PixelNet' THEN 'suzy@pixelnet.com'
        WHEN c.name = 'Amazon Services' THEN 'admin@amazon.com'
        WHEN c.name = 'ACME Corporation' THEN 'steve@acme.com'
        ELSE NULL
    END,
    CASE 
        WHEN c.name IN ('Paramount Group Inc', '8th Floor- 50 Beale St', 'PixelNet', 'Amazon Services', 'ACME Corporation') THEN '818-555-9789'
        ELSE NULL
    END
FROM clients c;

-- Insert sample products
INSERT INTO products (sku, name, description, category, subcategory, type, specifications, unit_price, unit_type, units_per_case, case_price, image_url, status) VALUES
('JHBL-24000LM-GL-WD-MVOLT-GZ10-50K-80CRI-HC3P-DWH', 'INTERMATIC Spring Wound Timer', 'INTERMATIC Spring Wound Timer, Timing Range 1 Hour, Contact Form SPST, Power Rating @ 125 VAC 1 HP, Power Rating @ 250 VAC 2 HP, Load Capacity @ 125 VAC 20/7 Amps, Load Capacity @ 250 VAC 10 Amps, Hold Feature No, 2 x 4 In', 'RELAMP', 'Timers', 'Ballast', '{"dimensions": "2 x 2 parabolic", "voltage": "125-250 VAC", "capacity": "20/7 Amps"}', 27.00, 'units', 24, 648.00, '/placeholder.svg?height=60&width=60&text=Ballast', 'available'),
('DVF-103P-WH', 'Lutron Preset Dimmer', 'Lutron Preset Dimmer with Nightlight for Fluorescent Dimming with Hi-Lume EcoSystem electronic ballasts Single Pole or 3-Way', 'RELAMP', 'Dimmers', 'Dimmer', '{"type": "Preset", "compatibility": "Hi-Lume EcoSystem", "mounting": "Single Pole or 3-Way"}', 897.00, 'units', 1, 897.00, '/placeholder.svg?height=60&width=60&text=Dimmer', 'assigned'),
('B94C', 'GE Commercial Electric 6" LED Recessed Downlight', 'Commercial Electric 6" LED Recessed Downlight', 'RELAMP', 'Fixtures', 'Fixture', '{"size": "6 inch", "type": "LED Recessed", "bulbs": 24}', 220.00, 'unit', 1, 220.00, '/placeholder.svg?height=60&width=60&text=Fixture', 'available'),
('B95D', 'GE Replacement LED Bulbs', 'Replacement LED bulbs', 'RELAMP', 'Bulbs', 'Bulbs', '{"type": "LED", "replacement": true}', 2.06, 'units', 48, 99.00, '/placeholder.svg?height=60&width=60&text=Bulbs', 'available'),
('TL-30W-ADJ', 'Track Light Fixture', 'Adjustable Track Light Fixture 30W', 'FIXTURES', 'Track Lights', 'Fixture', '{"wattage": "30W", "lumens": "3000lm", "adjustable": true}', 79.99, 'unit', 1, 79.99, '/placeholder.svg?height=60&width=60&text=Track+Light', 'available'),
('ES-LED-DUAL', 'Emergency Exit Sign', 'LED Emergency Exit Sign with Dual Heads', 'EMERGENCY', 'Exit Signs', 'Emergency', '{"wattage": "3W", "type": "Dual Head", "battery_backup": true}', 49.99, 'unit', 1, 49.99, '/placeholder.svg?height=60&width=60&text=Exit+Sign', 'available');

-- Insert sample orders
INSERT INTO orders (order_number, client_id, ordered_by, ordered_by_email, status, total_amount, notes) 
SELECT 
    'PO-ACME-27',
    c.id,
    'Steve Jackson',
    'steve@acme.com',
    'invoiced',
    1500.00,
    'ACME Maintenance order'
FROM clients c WHERE c.name = 'ACME Corporation';

INSERT INTO orders (order_number, client_id, ordered_by, ordered_by_email, status, total_amount, notes) 
SELECT 
    'PO-ACME-26',
    c.id,
    'Steve Jackson',
    'steve@acme.com',
    'shipped',
    2200.00,
    'ACME Maintenance order'
FROM clients c WHERE c.name = 'ACME Corporation';

INSERT INTO orders (order_number, client_id, ordered_by, ordered_by_email, status, total_amount, notes) 
SELECT 
    '1234',
    c.id,
    'Suzzane',
    'suzz@dot.com',
    'in_arrears',
    850.00,
    '7th Floor One Market Plaza'
FROM clients c WHERE c.name = '7th Floor- One Market Plaza';

INSERT INTO orders (order_number, client_id, ordered_by, ordered_by_email, status, total_amount, notes) 
SELECT 
    'A987612',
    c.id,
    'Molly',
    'molly@paramountgroup.com',
    'in_process',
    3200.00,
    '50 Beale Street Paramount Group'
FROM clients c WHERE c.name = 'Paramount Group Inc';

-- Assign some products to clients
INSERT INTO client_products (client_id, product_id)
SELECT c.id, p.id
FROM clients c, products p
WHERE c.name = 'Paramount Group Inc' AND p.sku IN ('JHBL-24000LM-GL-WD-MVOLT-GZ10-50K-80CRI-HC3P-DWH', 'DVF-103P-WH', 'B94C');

INSERT INTO client_products (client_id, product_id)
SELECT c.id, p.id
FROM clients c, products p
WHERE c.name = 'ACME Corporation' AND p.sku IN ('B95D', 'TL-30W-ADJ');
