-- 1. Tabela de Perfis
CREATE TABLE profiles (
    id UUID REFERENCES auth.users(id) ON DELETE CASCADE PRIMARY KEY,
    full_name TEXT NOT NULL,
    bio TEXT,
    location TEXT,
    website_social TEXT,
    avatar_url TEXT,
    member_since TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    is_verified BOOLEAN DEFAULT false,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. Tabela de Seguidores (Para o contador de "Followers")
CREATE TABLE follows (
    follower_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    following_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    PRIMARY KEY (follower_id, following_id)
);

-- 3. Tabela de Carros (car_model.dart)
CREATE TABLE cars (
    id TEXT PRIMARY KEY, -- Mantido TEXT para compatibilidade com o modelo Dart
    brand TEXT NOT NULL,
    model TEXT NOT NULL,
    year INT NOT NULL,
    price NUMERIC(12, 2) NOT NULL,
    price_label TEXT NOT NULL,
    image_url TEXT NOT NULL,
    image_alt TEXT NOT NULL,
    mileage INT NOT NULL,
    mileage_label TEXT NOT NULL,
    fuel_type TEXT NOT NULL,
    transmission TEXT NOT NULL,
    color TEXT NOT NULL,
    is_certified BOOLEAN NOT NULL DEFAULT false,
    is_top_deal BOOLEAN NOT NULL DEFAULT false,
    badge TEXT,
    gallery_images TEXT[], -- Lista de strings para galeria
    technical_specs JSONB, -- Map para especificações técnicas
    seller_description TEXT,
    seller_id UUID REFERENCES profiles(id) ON DELETE CASCADE, -- Dono do anúncio
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 4. Tabela de Avaliações (secção Ratings & Reviews)
CREATE TABLE reviews (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    seller_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    reviewer_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    rating INT CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    car_model_bought TEXT, -- Ex: "Purchased BMW M3"
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 5. Tabela de Pesquisas Guardadas (saved_search.dart)
CREATE TABLE saved_searches (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    listing_count INT NOT NULL DEFAULT 0,
    new_listings_today INT NOT NULL DEFAULT 0,
    filters JSONB NOT NULL, -- Para guardar o Map de filtros
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
