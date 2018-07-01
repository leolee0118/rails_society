class ClubsController < ApplicationController

    wrap_parameters format: [:json]
    before_action only: [ :filtered_index, :show, :add_member, :create_article, :create_event] do
        set_user(2)
    end

    def filtered_index
        response = Hash.new
        order_way = []
        filter = Hash.new
        if params["keyword"]
            filter[:name] = params["keyword"] #string
        end
        if params["rank"]
            filter[:rank] = params["rank"] #array-list
        end
        if params["category"]
            filter[:category] = params["category"]
        end
        # if parmas["latest"]
        #     order_way.push('created_at')
        # end
        # if params["popular"]
        #     order_way.push('COUNT(users.id)')
        # end
        case params["order_way"]
        when '1' #params are always string
            order_way.push('created_at DESC')
        when '2'
            order_way.push('COUNT(users.id) DESC')
        when '3'
            order_way.push('created_at DESC', 'COUNT(users.id) DESC')
        end
        ordered_club = Club.left_joins(:users).group(:id).order(order_way).where(filter)
        response[:clubs] = []
        ordered_club.all.each do |club|
            club_hash = Hash.new
            club_hash[:id] = club.id
            club_hash[:name] = club.name
            club_hash[:category] = club.category
            club_hash[:rank] = club.rank
            club_hash[:size] = club.users.count
            response[:clubs].push(club_hash)
        end
        # response[:order_way] = order_way
        render json: response
    end

    def show
        response = Hash.new
        club = Club.find(params[:id])
        manager = Hash.new  #manager
        manager[:id] = club.manager_user_id
        manager[:name] = User.find(club.manager_user_id).name
        response[:manager] = manager
        response[:members] = []     #member
        club.users.each do |user|
            unless user.id == club.manager_user_id
                mem_hash = Hash.new
                mem_hash[:id] = user.id
                mem_hash[:name] = user.name
                response[:members].push(mem_hash)
            end
        end
        response[:category] = club.category
        response[:rank] = club.rank
        response[:size] = club.users.count
        response[:description] = club.description
        response[:articles] = []    #article
        club.articles.each do |article|
            if article.is_public or club.users.include?(@current_user)
                art_hash = Hash.new
                art_hash[:id] = article.id
                art_hash[:title] = article.title
                art_hash[:author] = Hash.new
                art_hash[:author][:id] = article.user_id
                art_hash[:author][:name] = article.user.name
                art_hash[:content] = article.content
                response[:articles].push(art_hash)
            end
        end
        if club.users.include?(@current_user)    #event
            response[:events] = []
            club.events.each do |event|
                eve_hash = Hash.new
                eve_hash[:id] = event.id
                eve_hash[:title] = event.title
                eve_hash[:size] = event.users.count
                response[:events].push(eve_hash)
            end
        end
        render json: response
    end

    def add_member
        response = Hash.new
        club = Club.find(params[:id])
        response[:result] = "failed"
        unless club.users.include?(@current_user)
            club.users.push(@current_user)
            response[:result] = "succeed"
        end
        render json: response
    end

    def create_article
        response = Hash.new
        article = Article.new
        article.user_id = @current_user.id
        article.club_id = params[:id]
        article.title = params[:title]
        article.content = params[:content]
        article.is_public = params[:is_public]
        response[:result] = article.save ? "succeed" : "failed"
        render json: response
    end

    def create_event
        response = Hash.new
        event = Event.new
        event.creator_user_id = @current_user.id
        event.club_id = params[:id]
        event.title = params[:title]
        event.description = params[:description]
        event.is_public = params[:is_public]
        event.start_time = params[:start_time]
        event.until_time = params[:until_time]
        response[:result] = event.save ? "succeed" : "failed"
        render json: response
    end

    private

    def set_user(user_id)
        @current_user = User.find(user_id)
    end

end
