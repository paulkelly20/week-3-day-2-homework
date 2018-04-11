require("pg")
class SpaceCowboy
  attr_reader :id
  attr_accessor :name, :species, :bounty_value, :homeworld

  def initialize(new_hash)
    @id = new_hash["id"].to_i
    @name = new_hash["name"]
    @species = new_hash["species"]
    @bounty_value = new_hash["bounty_value"].to_i
    @homeworld = new_hash["homeworld"]
  end

  def save()
    db = PG.connect({ dbname: "space_cowboys", host:"localhost"})
    sql = "INSERT INTO bounties (name, species, bounty_value, homeworld) VALUES ($1, $2, $3, $4) RETURNING id;"
    values = [@name, @species, @bounty_value, @homeworld]
    db.prepare("save", sql)
    result = db.exec_prepared("save", values)
    db.close()
    @id = result[0]["id"].to_i # result gets array back from database, first result is the a hash with key id and number of value id.
  end

  def self.all()
    db = PG.connect({dbname: "space_cowboys", host: "localhost"})
    sql = "SELECT * FROM bounties"
    db.prepare("all", sql)
    result = db.exec_prepared("all")
    db.close()
    return result.map { |space_cowboys| SpaceCowboy.new(space_cowboys) }
  end

  def update()
    db = PG.connect({dbname: "space_cowboys", host: "localhost"})
    sql = "UPDATE bounties SET (name, species, bounty_value, homeworld) = ($1, $2, $3, $4) WHERE id = $5"
    db.prepare("update", sql)
    dollar_signs = [@name, @species, @bounty_value, @homeworld, @id]
    db.exec_prepared("update", dollar_signs)
    db.close()
  end

  def delete()
    db = PG.connect({dbname: "space_cowboys", host: "localhost"})
    sql = "DELETE FROM bounties WHERE id = $1"
    db.prepare("delete", sql)
    dollar_signs = [@id]
    db.exec_prepared("delete", dollar_signs)
    db.close()
  end

  def self.find_by_name(name)
    db = PG.connect({dbname: "space_cowboys", host: "localhost"})
    sql = "SELECT * FROM bounties WHERE name = $1"
    db.prepare("find_by_name", sql)
    dollar_signs = [name]
     result = db.exec_prepared("find_by_name", dollar_signs)
    db.close()

    return result.map {|bounty_hash| SpaceCowboy.new(bounty_hash)}
  end

  def self.find_by_id(id)
    db = PG.connect({dbname: "space_cowboys", host: "localhost"})
    sql = "SELECT * FROM bounties WHERE id = $1"
    db.prepare("find_by_id", sql)
    dollar_signs = [id]
    result = db.exec_prepared("find_by_id", dollar_signs)
    db.close()
    bounty_hash = result[0]
    return SpaceCowboy.new(bounty_hash)
  end


  def self.delete_all()
    db = PG.connect({dbname: "space_cowboys", host: "localhost"})
    sql = "DELETE FROM bounties"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end
end
