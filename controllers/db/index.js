const db = require('knex')({
  client: 'pg',
  connection: process.env.POSTGRES_URI
})

const getAll = (req, res, table) => {
  const { ...filter } = req.params
  return (async () => {
    try {
      const data = await db
        .select('*')
        .from(table)
        .where(filter)
      return res.status(200).json(data)
    } catch (e) {
      return res.status(400).json(e)
    }
  })()
}

const create = (req, res, table) => {
  const { ...body } = req.body
  const [values] = Object.values(body)
  return (async () => {
    try {
      const data = await db(table)
        .insert(values)
        .returning('*')
      return res.status(200).json(data)
    } catch (e) {
      return res.status(400).json(e)
    }
  })()
}

const remove = (req, res, table) => {
  const { ...id } = req.params
  return (async () => {
    try {
      const data = await db(table)
        .where(id)
        .del()
      return res.status(200).json(data)
    } catch (e) {
      return res.status(400).json(e)
    }
  })()
}

const update = (req, res, table) => {
  const { ...body } = req.body
  const [obj] = Object.values(body)
  const { id, ...updateValue} = obj;
  return (async () => {
    try {
      const data = await db(table)
        .where({ [id.name]: id.value })
        .update(fields)
        .returning('*')
      return res.status(200).json(data)
    } catch (e) {
      return res.status(400).json(e)
    }
  })()
}

const selectActions = (req, res) => {
  const { take, skip } = req.query
  return (async () => {
    try {
      const items = await db
        .select(['actiontype', 'actiondate', 'objecttype'])
        .from('actionlog')
        .limit(take)
        .offset(skip)
      // db returns array with object count inside
      let [totalCount] = await db('actionlog').count('actionid')
      totalCount = totalCount.count
      return res.status(200).json({ items, totalCount })
    } catch (e) {
      return res.status(400).json(e)
    }
  })()
}

module.exports = {
  selectActions,
  getAll,
  create,
  remove,
  update
}
