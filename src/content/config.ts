import { defineCollection, z } from 'astro:content';

const newsCollection = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    titleEn: z.string(),
    date: z.date(),
    image: z.string(),
    description: z.string(),
    descriptionEn: z.string(),
    published: z.boolean().default(true),
  }),
});

const galleryCollection = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    titleEn: z.string(),
    image: z.string(),
    order: z.number(),
    description: z.string(),
    descriptionEn: z.string(),
    published: z.boolean().default(true),
  }),
});

export const collections = {
  news: newsCollection,
  gallery: galleryCollection,
};
