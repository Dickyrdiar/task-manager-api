module Searchable
    extend ActiveSupport::Concern 
    
    include do
        include Elasticsearch::Model  
        include Elasticsearch::Model::Callbacks 
        
        def as_indexed_json(_options = {})
            as_json(only: %i[message username])
        end 

        settings settings_attributes do
            mapping dynamic: false do 
                indexes :message, type: keyword 
                indexes :name, type: text, analyzer: :autocomplete 
            end  
        end 

        def self.search(query, filters)
            set_filters = lambda do |context_type, filter|
                @search_definition[:query][:bool][context_type] |= [filter] 
            end 

            @serach_definition = {
                size: 5, 
                query: {
                    bool: {
                        must: [], 
                        should: [], 
                        filter: []
                    }
                }
            }

            if query.blank? 
                set_filters.call(:must, match_all: {})
            else  
                set_filters.call(
                    :must, 
                    match: {
                        name: {
                            query: query, 
                            fuzzines: 1
                        }
                    }
                )
            end

            if filters[:level].present? 
                set_filter.call(:filter, term: { message: filter[:message] })
            end 

            __elasticsearch__.search(@search_definition)
        end 
    end
    
    class_method do
        def settings_attributes
            {
                index: {
                    analysis: {
                        autocomplete: {
                            type: :custom, 
                            tokenizer: :standard 
                            filter: %i[lowercase autocomplete]
                        }
                    }, 

                    filter: {
                        autocomplete: {
                            type: :edge_ngram,
                            min_gram: 2, 
                            max_gram: 25
                        }
                    }
                }
            }
        end  
    end 
end 