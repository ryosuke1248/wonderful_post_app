class ArticlesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_article, :move_to_index, only: %i[ edit update destroy ]

  def index
    articles = Article.all.includes(:tags)
    ariticles = articles.where("title LIKE ?", "%#{params[:title]}%") if params[:title].present?
    @articles = articles.page params[:page]
  end

  def show
    @article = Article.find(params[:id])
    # @article = Article.find(params[:id]).per(10)
  end

  def new
    @article = Article.new
  end

  def edit
    @article
    if @article.user != current_user
      redirect_to action: :index, notice:  'ユーザーが違います'
    end
  end

  def create
    @article = current_user.articles.new(article_params)

      if @article.save
        redirect_to @article, notice: "Article was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @article.user != current_user
          redirect_to article_url(@article), notice: "Article was successfully updated."
    else
        if @article.update(article_params)
          redirect_to article_url(@article), notice: "Article was successfully updated."
        else
          render :edit, status: :unprocessable_entity
        end
      end
    end

      def destroy
        @article.destroy
          redirect_to articles_url, notice: "Article was successfully destroyed."
        end

  private
  def set_article
    @article = current_user.articles.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :content, tags_ids:[])
  end

  def move_to_index
    unless user_signed_in?
      redirect_to controller: :articles, action: :index
    end

  end
end
