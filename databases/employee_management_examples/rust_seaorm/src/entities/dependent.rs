use sea_orm::entity::prelude::*;

#[derive(Clone, Debug, PartialEq, DeriveEntityModel)]
#[sea_orm(table_name = "dependent")]
pub struct Model {
    #[sea_orm(primary_key, auto_increment = false)]
    pub essn: String,
    #[sea_orm(primary_key, auto_increment = false)]
    pub dependent_name: String,
    pub sex: Option<String>,
    pub bdate: Option<Date>,
    pub relationship: Option<String>,
}

#[derive(Copy, Clone, Debug, EnumIter, DeriveRelation)]
pub enum Relation {}

impl ActiveModelBehavior for ActiveModel {}
