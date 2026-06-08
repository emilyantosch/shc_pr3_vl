import { useEffect, useState } from 'react';

const API_URL = import.meta.env.VITE_API_URL ?? 'http://localhost:8080/api/todos';

export default function App() {
  const [todos, setTodos] = useState([]);
  const [newDescription, setNewDescription] = useState('');
  const [editingId, setEditingId] = useState(null);
  const [editDescription, setEditDescription] = useState('');
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  useEffect(() => {
    loadTodos();
  }, []);

  async function loadTodos() {
    setLoading(true);
    setError('');

    try {
      const response = await fetch(API_URL);
      if (!response.ok) {
        throw new Error('Could not load todos.');
      }
      setTodos(await response.json());
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  }

  async function addTodo(event) {
    event.preventDefault();
    const description = newDescription.trim();
    if (!description) return;

    try {
      const created = await sendJson(API_URL, 'POST', { description, done: false });
      setTodos((currentTodos) => [...currentTodos, created]);
      setNewDescription('');
      setError('');
    } catch (err) {
      setError(err.message);
    }
  }

  async function toggleTodo(todo) {
    try {
      const updated = await sendJson(`${API_URL}/${todo.id}`, 'PUT', {
        description: todo.description,
        done: !todo.done,
      });
      replaceTodo(updated);
      setError('');
    } catch (err) {
      setError(err.message);
    }
  }

  function startEditing(todo) {
    setEditingId(todo.id);
    setEditDescription(todo.description);
  }

  function cancelEditing() {
    setEditingId(null);
    setEditDescription('');
  }

  async function saveEdit(todo) {
    const description = editDescription.trim();
    if (!description) return;

    try {
      const updated = await sendJson(`${API_URL}/${todo.id}`, 'PUT', {
        description,
        done: todo.done,
      });
      replaceTodo(updated);
      cancelEditing();
      setError('');
    } catch (err) {
      setError(err.message);
    }
  }

  async function deleteTodo(id) {
    try {
      const response = await fetch(`${API_URL}/${id}`, { method: 'DELETE' });
      if (!response.ok) {
        throw new Error('Could not delete todo.');
      }
      setTodos((currentTodos) => currentTodos.filter((todo) => todo.id !== id));
      setError('');
    } catch (err) {
      setError(err.message);
    }
  }

  function replaceTodo(updatedTodo) {
    setTodos((currentTodos) =>
      currentTodos.map((todo) => (todo.id === updatedTodo.id ? updatedTodo : todo)),
    );
  }

  return (
    <main className="app">
      <section className="todo-card">
        <h1>Todo List</h1>

        <form className="add-form" onSubmit={addTodo}>
          <input
            aria-label="New todo description"
            placeholder="What needs to be done?"
            value={newDescription}
            onChange={(event) => setNewDescription(event.target.value)}
          />
          <button type="submit">Add</button>
        </form>

        {error && <p className="error">{error}</p>}
        {loading && <p>Loading todos...</p>}

        {!loading && todos.length === 0 && <p className="empty-state">No todos yet.</p>}

        <ul className="todo-list">
          {todos.map((todo) => (
            <li key={todo.id} className={todo.done ? 'todo done' : 'todo'}>
              <input
                aria-label={`Mark ${todo.description} as ${todo.done ? 'not done' : 'done'}`}
                type="checkbox"
                checked={todo.done}
                onChange={() => toggleTodo(todo)}
              />

              {editingId === todo.id ? (
                <>
                  <input
                    aria-label="Edit todo description"
                    className="edit-input"
                    value={editDescription}
                    onChange={(event) => setEditDescription(event.target.value)}
                    onKeyDown={(event) => {
                      if (event.key === 'Enter') saveEdit(todo);
                      if (event.key === 'Escape') cancelEditing();
                    }}
                  />
                  <button type="button" onClick={() => saveEdit(todo)}>
                    Save
                  </button>
                  <button type="button" className="secondary" onClick={cancelEditing}>
                    Cancel
                  </button>
                </>
              ) : (
                <>
                  <span>{todo.description}</span>
                  <button type="button" onClick={() => startEditing(todo)}>
                    Edit
                  </button>
                </>
              )}

              <button type="button" className="danger" onClick={() => deleteTodo(todo.id)}>
                Delete
              </button>
            </li>
          ))}
        </ul>
      </section>
    </main>
  );
}

async function sendJson(url, method, body) {
  const response = await fetch(url, {
    method,
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(body),
  });

  if (!response.ok) {
    const message = await response.text();
    throw new Error(message || 'Request failed.');
  }

  return response.json();
}
