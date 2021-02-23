require 'rom'
require_relative 'database'

DB = ROM.container(:sql, DATABASE_URL) do |config|

  config.relation(:genres) do
    auto_struct true
    schema(infer: true) do
    end
  end

  config.relation(:clients) do
    auto_struct true
    schema(infer: true) do
      associations do
        many_to_many :contents, as: :seen, through: :clients_contents
        many_to_many :contents, as: :liked, through: :clients_contents_liked
        has_many :clients_contents, as: :contents_seen_date
      end
    end
  end

  config.relation(:clients_contents) do
    auto_struct true
    schema(infer: true) do
      associations do
        belongs_to :client
        belongs_to :content
      end
    end
  end

  config.relation(:clients_episodes) do
    auto_struct true
    schema(infer: true) do
      associations do
        belongs_to :client
        belongs_to :episode
      end
    end
  end

  config.relation(:clients_contents_liked) do
    auto_struct true
    schema(infer: true) do
      associations do
        belongs_to :client
        belongs_to :content
      end
    end
  end

  config.relation(:clients_episodes_liked) do
    auto_struct true
    schema(infer: true) do
      associations do
        belongs_to :client
        belongs_to :episode
      end
    end
  end

  config.relation(:contents) do
    auto_struct true
    schema(infer: true) do
      associations do
        belongs_to :genres
        many_to_many :clients, as: :seen_by, through: :clients_contents
        many_to_many :clients, as: :liked_by, through: :clients_contents_liked
        has_many :seasons
      end
    end
  end

  config.relation(:seasons) do
    auto_struct true
    schema(infer: true) do
      associations do
        belongs_to :contents
        has_many :episodes
      end
    end
  end

  config.relation(:episodes) do
    auto_struct true
    schema(infer: true) do
      associations do
        belongs_to :seasons
        many_to_many :clients, as: :seen_by, through: :clients_episodes
        many_to_many :clients, as: :liked_by, through: :clients_episodes_liked
      end
    end
  end

end
