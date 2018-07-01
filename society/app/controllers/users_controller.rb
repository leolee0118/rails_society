class UsersController < ApplicationController

    wrap_parameters format: [:json]

    def show
        response = Hash.new
        user = User.find(params[:id])
        data = Hash.new
        data[:name] = user.name
        data[:student_id] = user.student_id
        data[:email] = user.email
        data[:description] = user.description
        response[:data] = data
        response[:clubs] = []
        user.clubs.each do |club|
            club_hash = Hash.new
            club_hash[:id] = club.id
            club_hash[:name] = club.name
            #should have club field data!
            response[:clubs].push(club_hash)
        end
        response[:interests] = []
        user.interests.each do |it|
            it_hash = Hash.new
            it_hash[:field] = it.field
            it_hash[:rank] = it.rank
            it_hash[:description] = it.description
            response[:interests].push(it_hash)
        end
        response[:articles] = []
        user.articles.each do |art|
            if art.is_public
                art_hash = Hash.new
                art_hash[:id] = art.id
                art_hash[:title] = art.title
                art_hash[:content] = art.content
                response[:articles].push(art_hash)
            end
        end
        render json: response
    end

    def update
        response = Hash.new
        user = User.find(params[:id])
        user.name = params[:name]
        user.student_id = params[:student_id]
        user.email = params[:email]
        user.description = params[:description]
        response[:result] = user.save ? "succeed" : "failed"
        render json: response
    end

    def update_interests
        response = Hash.new
        response[:result] = "succeed"
        params[:data].zip(User.find(params[:id]).interests).each do |new_it, user_it|
            user_it.field = new_it[:field]
            user_it.description = new_it[:description]
            user_it.rank = new_it[:rank]
            response[:result] = "failed" unless user_it.save
        end
        render json: response
    end

    def create_club
        response = Hash.new
        club = Club.new
        club.name = params[:name]
        club.description = params[:description]
        club.category = params[:category]
        club.rank = params[:rank]
        club.manager_user_id = params[:id]
        club.users.push(User.find(params[:id]))
        response[:result] = club.save ? "succeed" : "failed"
        render json: response
    end

    def create_article
        response = Hash.new
        article = Article.new
        article.user_id = params[:id]
        article.title = params[:title]
        article.content = params[:content]
        article.is_public = params[:is_public]
        response[:result] = article.save ? "succeed" : "failed"
        render json: response
    end

end
