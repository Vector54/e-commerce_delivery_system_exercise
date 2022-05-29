require 'rails_helper'

RSpec.describe ShippingCompany, type: :model do
  describe "#valid?" do
    context "presence" do
      it "of everything" do
        sc = ShippingCompany.new(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
                            email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
                            billing_adress: 'Rua do Seu Carlos, 86', active: true)
        r = sc.valid?
        
        expect(r).to eq true
      end

      it "but name" do
        sc = ShippingCompany.new(name:"", corporate_name:"FRETE DO SEU CARLOS LTDA",
                            email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
                            billing_adress: 'Rua do Seu Carlos, 86', active: true)
        r = sc.valid?
        
        expect(r).to eq false
      end

      it "but corporate name" do
        sc = ShippingCompany.new(name:"Frete do Seu Carlos", corporate_name:"",
                            email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
                            billing_adress: 'Rua do Seu Carlos, 86', active: true)
        r = sc.valid?
        
        expect(r).to eq false
      end

      it "but email domain" do
        sc = ShippingCompany.new(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
                            email_domain:"", cnpj: "06.902.995/0001-62",
                            billing_adress: 'Rua do Seu Carlos, 86', active: true)
        r = sc.valid?
        
        expect(r).to eq false
      end

      it "but cnpj" do
        sc = ShippingCompany.new(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
                            email_domain:"seucarlosfrete.com.br", cnpj: "",
                            billing_adress: 'Rua do Seu Carlos, 86', active: true)
        r = sc.valid?
        
        expect(r).to eq false
      end

      it "but billing adress" do
        sc = ShippingCompany.new(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
                            email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
                            billing_adress: '', active: true)
        r = sc.valid?
        
        expect(r).to eq false
      end

      it "but active" do
        sc = ShippingCompany.new(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
                            email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
                            billing_adress: 'Rua do Seu Carlos, 86', active: '' )
        r = sc.valid?
        
        expect(r).to eq true
      end
    end

    context "format" do
      it 'of CNPJ is valid' do
        sc = ShippingCompany.new(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
          email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
          billing_adress: 'Rua do Seu Carlos, 86', active: true)
        
        r = sc.valid?

        expect(r).to eq true
      end
     
      it 'of CNPJ is valid' do
        sc = ShippingCompany.new(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
          email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/001-62",
          billing_adress: 'Rua do Seu Carlos, 86', active: true)
        
        r = sc.valid?

        expect(r).to eq false
      end
      
      it 'of email domain is valid' do
        sc = ShippingCompany.new(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
          email_domain:"seucarlosfrete.com.br", cnpj: "06.902.995/0001-62",
          billing_adress: 'Rua do Seu Carlos, 86', active: true)
        
        r = sc.valid?

        expect(r).to eq true
      end

      it 'of email domain is invalid' do
        sc = ShippingCompany.new(name:"Frete do Seu Carlos", corporate_name:"FRETE DO SEU CARLOS LTDA",
          email_domain:"@seucarlosfretecom.br", cnpj: "06.902.995/0001-62",
          billing_adress: 'Rua do Seu Carlos, 86', active: true)
        
        r = sc.valid?

        expect(r).to eq false
      end
    end

  end
end
