# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#--------------------------------------------------------------------------------    
def putinfo (txt)
  info = "== Seed #{txt} "
  info += '=' * (79 - info.length)
  puts info
end

#--------------------------------------------------------------------------------    
def first_or_create_for(model, identifier, opts = {})
  model.where(identifier).first_or_create(opts)
end

if User.all.empty?
  putinfo('Users')

  # ADMIN
  identifier = { email: 'admin@selectra.info' }
  opts = {
    password: 'selectra',
    firstname: 'admin',
    admin: true,
    teleop: true,
    galp: true,
  }.merge(identifier)
  first_or_create_for(User, identifier, opts)

  # TELEOP
  identifier = { email: 'teleop@selectra.info' }
  opts = {
    password: 'selectra',
    firstname: 'teleop',
    admin: false,
    teleop: true,
    galp: false,
  }.merge(identifier)
  first_or_create_for(User, identifier, opts)

  # galp
  identifier = { email: 'galp@selectra.info' }
  opts = {
    password: 'selectra',
    firstname: 'galp',
    admin: false,
    teleop: false,
    galp: true,
  }.merge(identifier)
  first_or_create_for(User, identifier, opts)  
end


#--------------------------------------------------------------------------------    
def some_status
  Contract.galp_status.values.sample
end

#--------------------------------------------------------------------------------    
def some_tipo
  Contract.tipo.values.sample
end

#--------------------------------------------------------------------------------    
def create_gaz_contract(num)
  GazContract.create!(
    contract_id: num,
    apellido_antiguo_titular_gas: "former_gaz_owner_#{num}",
  )
end

#--------------------------------------------------------------------------------    
def create_luz_contract(num)
  LuzContract.create!(
    contract_id: num,
    apellido_antiguo_titular_luz: "former_luz_owner_#{num}",
  )
end

NB_CONTRACTS = 5

if Contract.all.empty?
  putinfo('Contract')

  # CONTRACT
  (1..NB_CONTRACTS).each do |i|
    tipo = some_tipo()

    contract = Contract.create!(
      apellido: "apellido#{i}",
        nombre: "nombre#{i}",
   galp_status: some_status(),
          tipo: tipo,
       confort: "no",
         state: Contract.state.values.sample(1).first
    )
    contract.build_gaz_contract()
    contract.build_luz_contract()
    create_gaz_contract(i)
    create_luz_contract(i)
  end


  # FOR GAZ SUMMARY - titular final
  contract = Contract.create!(
      apellido: "apellido",
        nombre: "client",
   galp_status: some_status(),
          tipo: "gas",
       confort: "no",
 titular_final: "Javier",
dni_titular_final: "AAAAA",
    telefono_1: "1234567890",
         email: "javier@javier.com",
  )
  contract.build_gaz_contract()
  contract.build_luz_contract()

  GazContract.create!(
    contract_id: Contract.last.id,
    apellido_antiguo_titular_gas: "foo",
    cups_gas: "cups_gaz",
  )
  contract.save
  
  # FOR GAZ SUMMARY - representante
  contract = Contract.create!(
      apellido: "apellido",
        nombre: "client",
   galp_status: some_status(),
          tipo: "luz",
       confort: "no",
 titular_final: "Piedro",
 representante: "Alejandro",
dni_titular_final: "BBBBB",
dni_representante: "CCCCC",
    telefono_1: "1234567890",
         email: "piedro@foo.com",
  )
  contract.build_gaz_contract()
  contract.build_luz_contract()
  
  LuzContract.create!(
    contract_id: Contract.last.id,
    apellido_antiguo_titular_luz: "bar",
    cups_luz: "cups_luz",
  )
  contract.save

end

