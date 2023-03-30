class MypageController < ApplicationController
    def show
      articles = current_user.articles.includes(:tags)
      articles = ariticles.where("title LIKE ?", "%#{[:title]}%") if params[:title].present?
      @articles = current_user.articles.page  params[:page]
    end
end
