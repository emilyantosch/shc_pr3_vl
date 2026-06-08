use sea_orm::entity::prelude::*;

#[derive(Clone, Debug, PartialEq, DeriveEntityModel)]
#[sea_orm(table_name = "department")]
pub struct Model {
    #[sea_orm(primary_key, auto_increment = false)]
    pub dnumber: i32,
    pub dname: String,
    pub mgr_ssn: Option<String>,
    pub mgr_start_date: Option<Date>,
}

#[derive(Copy, Clone, Debug, EnumIter, DeriveRelation)]
pub enum Relation {}

impl ActiveModelBehavior for ActiveModel {}
