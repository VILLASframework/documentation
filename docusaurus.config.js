// @ts-check
// Note: type annotations allow type checking and IDEs autocompletion

const lightCodeTheme = require('prism-react-renderer/themes/github');
const darkCodeTheme = require('prism-react-renderer/themes/dracula');

/** @type {import('@docusaurus/types').Config} */
const config = {
    title: 'VILLASframework',
    tagline: 'VILLASframework is a toolset for local and geographically distributed real-time co-simulation.',
    url: 'https://villas.fein-aachen.org',
    baseUrl: '/',
    onBrokenLinks: 'throw',
    onBrokenMarkdownLinks: 'warn',
    favicon: 'img/logos/villas_framework.svg',
    organizationName: 'VILLASframework',
    projectName: 'Documentation',

    scripts: [{
        src: '/js/asciinema-player.js',
        defer: true,
    }, ],

    stylesheets: [
        '/css/asciinema-player.css'
    ],

    presets: [
        [
            '@docusaurus/preset-classic',
            /** @type {import('@docusaurus/preset-classic').Options} */
            ({
                docs: {
                    sidebarPath: require.resolve('./sidebars.js'),
                    editUrl: 'https://git.rwth-aachen.de/acs/public/villas/documentation/-/edit/master/',
                    remarkPlugins: [
                        require('mdx-mermaid'),
                    ]
                },
                blog: {
                    showReadingTime: true,
                    editUrl: 'https://git.rwth-aachen.de/acs/public/villas/documentation/-/edit/master/',
                },
                theme: {
                    customCss: require.resolve('./src/css/custom.css'),
                },
            }),
        ],
        [
            'redocusaurus',
            {
                specs: [{
                        routePath: '/api/node/',
                        // Generated my Makefile
                        spec: 'generated/node/openapi.yaml',
                    },
                    {
                        routePath: '/api/relay/',
                        spec: 'external/node/doc/openapi-relay.yaml',
                    },
                    {
                        routePath: '/api/controller/',
                        spec: 'external/controller/doc/openapi.yaml',
                    },
                    {
                        routePath: '/api/web/',
                        // TODO this file is currently manually converter to OpenAPI spec v3
                        // See: https://git.rwth-aachen.de/acs/public/villas/web-backend-go/-/issues/85
                        spec: 'generated/web/openapi.yaml',
                    },
                ],
            },
        ],
    ],

    themeConfig:
    /** @type {import('@docusaurus/preset-classic').ThemeConfig} */
        ({
        navbar: {
            title: 'VILLASframework',
            logo: {
                alt: 'VILLASframework logo',
                src: 'img/logos/villas_framework.svg',
            },
            items: [{
                    type: 'doc',
                    docId: 'index',
                    position: 'left',
                    label: 'Documentation',
                },
                {
                    to: 'blog',
                    label: 'Blog',
                    position: 'left'
                },
                {
                    href: 'https://fein-aachen.org/',
                    label: 'FEIN Aachen e.V.',
                    position: 'right',
                },
                {
                    href: 'https://git.rwth-aachen.de/acs/public/villas/',
                    label: 'GitLab',
                    position: 'right',
                },
            ],
        },
        footer: {
            logo: {
                alt: 'RWTH Aachen',
                src: 'img/logos/eonerc_dark.png',
                href: 'https://acs.eonerc.rwth-aachen.de',
            },
            style: 'dark',
            links: [{
                    title: 'Docs',
                    items: [{
                        label: 'Documentation',
                        to: '/docs/index',
                    }, {
                        label: 'FEIN Aachen e.V.',
                        href: 'https://www.fein-aachen.org',
                    }, ],
                },
                {
                    title: 'Community',
                    items: [{
                            label: 'RWTH Aachen University',
                            href: 'https://www.rwth-aachen.de',
                        },
                        {
                            label: 'E.ON Energy Research Center',
                            href: 'https://eonerc.rwth-aachen.de',
                        },
                        {
                            label: 'Insitute for Automation of Complex Power Systems',
                            href: 'https://acs.eonerc.rwth-aachen.de',
                        },
                    ],
                },
                {
                    title: 'More',
                    items: [{
                            label: 'Blog',
                            to: '/blog',
                        },
                        {
                            label: 'GitLab',
                            href: 'https://git.rwth-aachen.de/acs/public/villas',
                        },
                    ],
                },
            ],
            copyright: `Copyright © ${new Date().getFullYear()} Institute for Automation of Complex Power Systems, RWTH Aachen University.`,
        },
        prism: {
            theme: lightCodeTheme,
            darkTheme: darkCodeTheme,
        },
    }),
};

module.exports = config;
