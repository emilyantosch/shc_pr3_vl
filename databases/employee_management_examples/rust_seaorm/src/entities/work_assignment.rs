use sea_orm::entity::prelude::*;

#[derive(Clone, Debug, PartialEq, DeriveEntityModel)]
#[sea_orm(table_name = "works_on")]
pub struct Model {
    #[sea_orm(primary_key, auto_increment = false)]
    pub essn: String,
    #[sea_orm(primary_key, auto_increment = false)]
    pub pno: i32,
    pub hours: Option<f64>,
}

#[derive(Copy, Clone, Debug, EnumIter, DeriveRelation)]
pub enum Relation {}

impl ActiveModelBehavior for ActiveModel {}
