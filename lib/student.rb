class Student
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id=nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
      );
      SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE students;"
    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
      INSERT INTO students
      VALUES (?,?,?)
    SQL

    DB[:conn].execute(sql, self.id, self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]

  end

  def self.create(hash)
    self.create_table
    student = self.new(hash)
    student.save
  end
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

end
