class CandidatesController < ApplicationController
  before_action :set_candidate, only: [:show, :edit, :update, :destroy]

  # GET /job_postings/1/candidates
  # GET /job_postings/1/candidates.json
  def index
    @candidates = Candidate.where(job_posting_id: params[:job_posting_id]).paginate(:page => params[:page], :per_page => 15)
  end

  # GET /job_postings/1/candidates/1
  # GET /job_postings/1/candidates/1.json
  def show
  end

  # GET /job_postings/1/candidates/new
  def new
    @job_posting = JobPosting.find(params[:job_posting_id])
    @candidate = @job_posting.candidates.build
  end

  # GET /job_postings/1/candidates/1/edit
  def edit
    @job_posting = @candidate.job_posting
  end

  # POST /job_postings/1/candidates
  # POST /job_postings/1/candidates.json
  def create
    @job_posting = JobPosting.find(params[:job_posting_id])
    @candidate = @job_posting.candidates.build(candidate_params)
    respond_to do |format|
      if @candidate.save
        trello = TrelloClient.new
        trello.list(@job_posting)
        trello.create_card(@candidate)
        format.html { redirect_to [@job_posting, @candidate], notice: 'Candidate was successfully created.' }
        format.json { render :show, status: :created, location: @candidate }
      else
        format.html { render :new }
        format.json { render json: @candidate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /job_postings/1/candidates/1
  # PATCH/PUT /job_postings/1/candidates/1.json
  def update
    respond_to do |format|
      if @candidate.update(candidate_params)
        format.html { redirect_to job_posting_candidate_url(job_posting_id: @candidate.job_posting_id, id: @candidate.id), notice: 'Candidate was successfully updated.' }
        format.json { render :show, status: :ok, location: @candidate }
      else
        format.html { render :edit }
        format.json { render json: @candidate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /job_postings/1/candidates/1
  # DELETE /job_postings/1/candidates/1.json
  def destroy
    @candidate.destroy
    respond_to do |format|
      format.html { redirect_to job_posting_candidate_url, notice: 'Candidate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_candidate
      @candidate = Candidate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def candidate_params
      params.require(:candidate).permit(:name, :email, :cover_letter)
    end
end
