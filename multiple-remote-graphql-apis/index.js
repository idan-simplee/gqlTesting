import {
  makeRemoteExecutableSchema,
  introspectSchema,
  mergeSchemas
} from 'graphql-tools';
import { HttpLink } from 'apollo-link-http';
import { ApolloServer } from 'apollo-server';
import fetch from 'node-fetch';

// graphql API metadata
const graphqlApis = {
  links:{
    uri: 'http://localhost:5000/graphql',
  },
  books:{
    uri: 'http://localhost:4000/graphql',
  }
};




// create executable schemas from remote GraphQL APIs
const createRemoteExecutableSchemas = async (api) => {
  const link = new HttpLink({
    uri: api.uri,
    fetch
  });
  const remoteSchema = await introspectSchema(link);
  const remoteExecutableSchema = makeRemoteExecutableSchema({
    schema: remoteSchema,
    link
  });
  return remoteExecutableSchema;
};


const linkTypeDefs = `
    extend type Book {
      links: [Link]
    }
    extend type Link {
      book: Book
    }
  `



const createNewSchema = async () => {
  // const remote_schemas = await createRemoteExecutableSchemas();
  const linksSchema = await createRemoteExecutableSchemas(graphqlApis.links)
  const booksSchema = await createRemoteExecutableSchemas(graphqlApis.books)
  return mergeSchemas({
    schemas: [linksSchema,booksSchema,linkTypeDefs],
    resolvers: {
    Book: {
      links: {
        fragment: `... on Book { title }`,
        resolve(book, args, context, info) {
          return info.mergeInfo.delegateToSchema({
            schema: linksSchema,
            operation: 'query',
            fieldName: 'linkByBookTitle',
            args: {
              bookTitle: book.title,
            },
            context,
            info,
          });
        },
      },
    },
    Link: {
      book: {
        fragment: `... on Link { bookTitle }`,
        resolve(link, args, context, info) {
          return info.mergeInfo.delegateToSchema({
            schema: booksSchema,
            operation: 'query',
            fieldName: 'book_by_title',
            args: {
              title: link.bookTitle,
            },
            context,
            info,
          });
        },
      },
    },
  },
  });
};

const runServer = async () => {
  // Get newly merged schema
  const schema = await createNewSchema();
  // start server with the new schema
  const server = new ApolloServer({
    schema
  });
  server.listen({port: 5001}).then(({url}) => {
    console.log(`Running at ${url}`);
  });
};

try {
  runServer();
} catch (err) {
  console.error(err);
}
