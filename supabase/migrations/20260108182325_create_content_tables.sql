/*
  # Create content management tables

  1. New Tables
    - `about` - Store about page content
    - `news` - Store news articles
    - `gallery` - Store gallery items
  2. Security
    - Enable RLS on all tables
    - Add policies for authenticated users
*/

CREATE TABLE IF NOT EXISTS about (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  title text NOT NULL DEFAULT 'About',
  description text DEFAULT '',
  image_url text DEFAULT '',
  updated_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS news (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  title text NOT NULL,
  content text DEFAULT '',
  image_url text DEFAULT '',
  published boolean DEFAULT true,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS gallery (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  title text NOT NULL,
  description text DEFAULT '',
  image_url text NOT NULL,
  sort_order integer DEFAULT 0,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

ALTER TABLE about ENABLE ROW LEVEL SECURITY;
ALTER TABLE news ENABLE ROW LEVEL SECURITY;
ALTER TABLE gallery ENABLE ROW LEVEL SECURITY;

-- Allow authenticated users to read all content
CREATE POLICY "Allow authenticated users to read about" ON about FOR SELECT TO authenticated USING (true);
CREATE POLICY "Allow authenticated users to read news" ON news FOR SELECT TO authenticated USING (true);
CREATE POLICY "Allow authenticated users to read gallery" ON gallery FOR SELECT TO authenticated USING (true);

-- Allow authenticated users to manage content
CREATE POLICY "Allow authenticated users to update about" ON about FOR UPDATE TO authenticated WITH CHECK (true);
CREATE POLICY "Allow authenticated users to insert news" ON news FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "Allow authenticated users to update news" ON news FOR UPDATE TO authenticated WITH CHECK (true);
CREATE POLICY "Allow authenticated users to delete news" ON news FOR DELETE TO authenticated USING (true);
CREATE POLICY "Allow authenticated users to insert gallery" ON gallery FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "Allow authenticated users to update gallery" ON gallery FOR UPDATE TO authenticated WITH CHECK (true);
CREATE POLICY "Allow authenticated users to delete gallery" ON gallery FOR DELETE TO authenticated USING (true);

-- Allow public to read published content
CREATE POLICY "Allow public to read about" ON about FOR SELECT TO anon USING (true);
CREATE POLICY "Allow public to read published news" ON news FOR SELECT TO anon USING (published = true);
CREATE POLICY "Allow public to read gallery" ON gallery FOR SELECT TO anon USING (true);