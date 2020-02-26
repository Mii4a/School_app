# spec/support/shared_examples.rb

  # http success case
  shared_examples "returns http success" do
    it { subject.call; expect(response).to have_http_status(200)}
  end
  
  # http success case when redirect" do
  shared_examples "returns http 302 when redirect" do
      it { subject.call; expect(response).to have_http_status(302)}
  end

  # redirect to path case
  shared_examples "redirect to path" do |path|
    it { subject.call; expect(response).to redirect_to(path) }
  end

  # create/update/delete model case
  shared_examples "create Model" do |model|
    it { expect{subject.call}.to change{model.count}.by(1) }
  end

  shared_examples "update Model" do |model|
    it { expect{subject.call}.to change{model.count}.by(0) }
  end

  shared_examples "delete Model" do |model|
    it { expect{subject.call}.to change{model.count}.by(-1) }
  end
  

  # eq case
  shared_examples "assinged value is @value" do |value|
    
    it {subject.call; expect(value).to eq(value)}
  end
  
  # flash[:success] case
  shared_examples "success message" do |msg|
      it {subject.call; expect(flash[:success]).to eq(msg)}
  end
  
  # flash[:danger] case
  shared_examples "error message" do |msg|
      it {subject.call; expect(flash[:danger]).to eq(msg)}
  end